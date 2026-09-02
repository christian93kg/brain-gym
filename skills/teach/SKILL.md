---
name: teach
description: Teach the user any subject - mathematics, sciences, languages, writing, speech, history, anything - by first measuring what they already know with graded quizzes, then planning a dependency graph from their measured edge to the goal, then teaching one reasoning step at a time with scored comprehension checks. Use when the user says "teach me X", "I want to learn X", "explain X" as a learning goal rather than a quick lookup, or invokes /teach. Also handles resuming an interrupted session and running due spaced reviews.
argument-hint: "[topic] [-- I already know X, Y] | --due | --status"
---

# /teach

A one-to-one tutor. Three phases: **PROBE** what the learner actually knows, **PLAN** the arc from
there to the goal, **TEACH** it one step at a time.

**Before doing anything else, read `${CLAUDE_SKILL_DIR}/PROTOCOL.md`.** It carries the rules this
session runs on and the evidence behind each one. It is not optional background — rules 1, 2 and 3
change what you are allowed to say in every single message. (`${CLAUDE_SKILL_DIR}` is this skill's
install directory; your working directory is the learner's, not the skill's.)

## Invocation

| Form | Behaviour |
|---|---|
| `/teach <topic>` | Start a new session on that topic |
| `/teach <topic> -- I already know <X, Y>` | Same, but seeds the probe so it runs shorter |
| `/teach` (bare) | Resume the most recent session whose `phase` is not `done` |
| `/teach --due` | Run spaced reviews for sessions whose `revisit_on` has passed |
| `/teach --status` | Print the learn index without starting anything |

Bare `/teach` with nothing unfinished: say so and ask for a topic. `--due` with nothing due: say so
and stop. `--status` never creates or modifies a file; if there is no index yet, say "no sessions yet".
On resume, the session note's frontmatter (`phase`, `node`) is the source of truth — never the chat
history, which may be stale after a reconnect or reboot.

---

## Storage

Everything persists as plain markdown under **`$TEACH_HOME`**, or the current working directory if
that variable is unset. Call that root `$ROOT`:

- `learn/<YYYY-MM-DD>-<topic-slug>.md` — one note per session
- `learn/index.md` — the session table
- `$LOG` = `log/` + the `log_file` value from `$ROOT/teach-config.md`, default `log/teach-log.md` —
  the scored-item log. Resolve `$LOG` once at session start and state both paths to the learner in
  your first message.

**Pick the backend once, before the first write — by checking, not by asking.** If `$ROOT/.obsidian/`
exists this is a synced Obsidian vault: **stop and read `${CLAUDE_SKILL_DIR}/STORAGE.md` now, run its
preflight, and use only the write path it gives.** A raw Write/Edit into a synced vault folder races
the app's own file watcher. Otherwise use the ordinary Write, Edit and Grep tools, and create `learn/`
and `log/` if they do not exist. Either way, run STORAGE.md's git-work-tree check first.

Starting templates for the index and the log are `${CLAUDE_SKILL_DIR}/templates/learn-index.md` and
`${CLAUDE_SKILL_DIR}/templates/teach-log.md`. When you create either file from its template, fill
`created:` and `updated:` with today's date. If the file already exists, leave its frontmatter alone.

Finding unfinished sessions on the plain-files backend: the Grep tool with pattern
`^phase: (probe|plan|teach)$` and path `learn`, or from a shell a form that survives an empty `learn/`:

    grep -rlE --include='*.md' '^phase: (probe|plan|teach)$' learn 2>/dev/null || true

Most recent = the greatest filename, since every session file starts with its date.

**Also check for `teach-config.md`** at `$ROOT`, either backend. If present, its frontmatter can
override the log filename and add fields/tags this installation wants on every session note and on
files created from the templates — see "Vault-local config" in `STORAGE.md`. Absent, all defaults
above apply unchanged.

---

## PHASE 1 - PROBE

Goal: a detailed map of the learner's understanding, measured rather than assumed. An optimal
teaching path minimises both teaching what they already hold and teaching what they cannot yet
reach, so you have to find the edge on every strand the topic depends on.

**Before asking anything:**

1. Read `learn/index.md` (create it if absent from `${CLAUDE_SKILL_DIR}/templates/learn-index.md`). Prior sessions in
   an adjacent subject are free probe data; use them and say you are using them.
2. Decompose the target topic into its **dependency strands** - the distinct prerequisite threads
   the goal rests on. Write them down. Differential forms, for example, has strands running through
   line integrals, vector calculus, linear algebra, and multivariable notation.
3. **Create the session note now** (`phase: probe`, strands under `## Probe`) and add its index row,
   so everything after this point is an append or a field update and an interrupted session is
   always resumable. If `learn/<date>-<slug>.md` already exists: if its `phase` is not `done`, offer
   to resume it instead; otherwise use `-2`, `-3`… on both the filename and the `id`. Never overwrite
   a session note.
4. Tell the learner: how many strands you found, that the probe may run long, and that they can
   shorten it by telling you what they already know.

**Then binary-search each strand:**

- Ask one broad item per strand first.
- **Correct, and confident** -> go one level deeper on that strand.
- **Wrong, or correct at `Guessing`** -> go one level shallower to find the floor.
- A confident wrong answer is the most informative result you can get. Note it; it is usually where
  the teaching arc has to start.

**Stopping rule.** Stop when running accuracy sits near the 85% band, or at **20 items**, whichever
comes first. **Announce the stop and why.** Never probe silently past the cap.

Then write the understanding map into the session note and move to PLAN.

### Quiz item format

One item is **one `AskUserQuestion` call carrying two paired questions** - the content question and
its probability - answered together, so confidence is committed before any feedback. The tutor runs
the quiz itself; it is never delegated to a subagent, because no subagent has `AskUserQuestion`.

Question 1 is the item: 2-4 options, header chip naming the strand. Question 2 is always exactly
this, verbatim:

- question: `How confident are you in that answer?`
- header: `Confidence`
- options:

| Label | Description | P |
|---|---|---|
| `Guessing (~30%)` | At or near chance - I would not be surprised to be wrong | 0.30 |
| `Leaning (~50%)` | Better than a coin flip, but not committed | 0.50 |
| `Fairly sure (~70%)` | Committed, but I would not bet the house | 0.70 |
| `Confident (~90%)` | I would be surprised to be wrong | 0.90 |

#### Documented limits of the tool — stay inside them

- At most 4 questions per call.
- 2-4 options per question, labels 1-5 words (put detail in the description, not the label).
- `multiSelect` off for every question here.
- Header chip ≤12 characters naming the strand — abbreviate once per strand and reuse it
  (`Vector calc`, `Lin alg`, `Line ints`, `MV notation`).
- Question text ends with `?`.
- The tool always adds an **Other** free-text option. On the content question, grade the typed
  answer as the item. On the confidence question, map the typed number to the nearest anchor in the
  table above; if confidence is missing or unmappable, ask for it again **before** saying anything
  about the content answer.
- **If the learner dismisses the call, treat it as not asked** - no score, no `node:` advance - and
  wait for them.

Rules:

- **Batch two items per call** (item A, confidence A, item B, confidence B) - fills the 4-question
  budget and keeps probing brisk.
- **Never split an item from its confidence question** across calls.
- **Never reveal correctness inside the same call.** Grade in the following message.
- `Guessing (~30%)` carries "I don't know". Add an explicit *"I don't know"* content option only
  when an item has fewer than 4 plausible distractors.
- Distractors must be plausible. An item with three obvious throwaways measures nothing and
  corrupts the calibration data.
- Record every item in the note as one table row `| # | Strand | Item | Answer | P | Outcome | Score |`
  so `--due` can re-draw it later.

Score every item as `(P - Outcome)^2`, Outcome 1 or 0. Track running accuracy and running Brier.

### Production items, for generative material

Multiple choice cannot test writing, speech, translation, or constructing a proof. For those nodes
use a production task instead - and keep predict-then-check. The same tool limits above apply.

1. Set the task.
2. **First** ask, via `AskUserQuestion`, which aspect they expect to be marked down on, plus the
   probability that it is the *main* weakness. That forecast is the scorable item.
3. They produce.
4. You critique against a rubric, then grade the forecast.

---

## PHASE 2 - PLAN

1. **Reason the whole arc out** from the measured starting point to the goal. One node per concept.
   Every node names its prerequisites. This phase is where the thinking happens - do not defer it
   into the teaching.
2. **Ask the intended retention** - "how long do you need to hold this?" (1 month / 6 months / 1
   year / other), via `AskUserQuestion`, in the same call as the go-ahead in step 5 if convenient.
   Write the answer as `retention_target:` in the frontmatter; rule 9's gap table keys on it.
3. **Emit a mermaid DAG** into the session note. Its purpose is to force the reasoning to be done
   up front rather than winged, and to show the learner what is coming. Use `graph TD`, node ids
   short, labels human. Mark which nodes the probe showed are already held.
4. **Fact-check, if and only if the topic is empirical** - history, medicine, nutrition, current
   practice, anything with contestable facts. Dispatch the `fact-check` agent once with a numbered
   list of the plan's load-bearing and incidental claims - it cannot ask back, so the list has to be
   complete on the first pass. Fold the results into `## Plan` as a `### Fact-check` table, and
   rewrite any node whose claim came back `wrong` or `contested`. **Skip it for self-verifying
   formal material** like mathematics; running it there produces citation theatre, not
   verification.
5. **Present the plan and wait for a go-ahead.** Do not start teaching in the same message.

---

## PHASE 3 - TEACH

Walk the DAG. Per node, in this shape:

1. **Ask for a prediction** about the node, with a probability. Never lead with the answer
   (PROTOCOL rule 1). If they ask you a question instead, ask them for a number first.
2. **Then teach the one node — by asking, not telling.** Default to guided questions that let the
   learner construct the idea, rather than exposition they receive. *(Pedagogical convention added
   by request; unlike the numbered `PROTOCOL.md` rules, it hasn't been run through this project's
   evidence pass.)*
   - **Lead with a question, not a statement** — point at the gap between what they predicted in
     step 1 and what's actually true, and ask them to reason across it. ("Given what you just said
     about X, what would that imply about Y?" instead of "Here's the concept.")
   - **Surface contradictions instead of correcting them.** When an answer conflicts with something
     they already committed to earlier in the session, name the conflict and ask them to resolve
     it — don't resolve it for them.
   - **Ask "why," not just "what."** A correct answer with no reasoning behind it isn't evidence
     the node landed (PROTOCOL rule 2) — press for the justification before moving on.
   - **Prefer open questions to yes/no.** "What do you think happens if—" over "Is it true that—".
   - **Let silence sit.** Don't fill a pause with the answer; a learner visibly working through a
     question is doing the job this step exists for.
   - **Escape hatch, so this doesn't become a stalling tactic:** after two guiding questions that
     don't move the learner closer, say so, then give the missing piece directly, framed as
     completing what they already built rather than a fresh lecture. Two unproductive rounds
     signals a missing prerequisite (tune per step 4), not a cue to keep circling.
   - Still **one reasoning step per message** — the questions are the delivery vehicle for that one
     step, not a way to sneak in a second.
3. **Then check comprehension** with a real scored item - never "does that make sense?"
   (PROTOCOL rule 2).
4. **Tune.** Running accuracy above ~95%, go harder or skip ahead; below ~70%, back up to
   prerequisites. Say which is happening and why.
5. Update `node:` in the session frontmatter to the next node id, and append the exchange to the note.

Interleave item types where the material allows (PROTOCOL rule 8). Use analogies
similarities-first, in the four-step order, and never lead with what does not map (rule 6).

### Closing a session

1. **Find the single worst-scoring item** and work out *why the learner's model produced that
   answer* - the belief behind it, not the correct answer. Check prior sessions for a miss of the
   same shape. This step is the intervention (PROTOCOL rule 5).
2. Append the session summary: running Brier, accuracy, nodes covered, the worst miss and its
   diagnosis.
3. Append all scored rows to `$LOG`, batched into one write.
4. Set `phase: done`, set `revisit_on` per PROTOCOL rule 9 from `retention_target`, and bump
   `updated`.
5. Update the index row in `learn/index.md`.
6. Tell the learner their Brier and accuracy, and when the revisit is due.

---

## Session note format

Path: `learn/<YYYY-MM-DD>-<topic-slug>.md`. Frontmatter:

```
---
id: <topic-slug>-<YYYY-MM-DD>
type: session
subject: <mathematics | biology | writing | ...>
status: active
created: <YYYY-MM-DD>
updated: <YYYY-MM-DD>
phase: probe
node: ""
revisit_on: ""
retention_target: ""
tags:
  - session
  - teach
  - <subject>
---
```

`subject` is the field being learned; it is what makes per-subject calibration possible, so always set
it. `status` stays `active` for the life of the note (vault convention - this is a live document, not
an archived one); `phase` is the actual state machine (`probe` → `plan` → `teach` → `done`) and is what
resuming and `--status` read. Bump `updated` at every phase change, not only at close.

Body sections, appended as the session moves: `## Probe`, `## Understanding map`, `## Plan` (with
the mermaid DAG), `## Teaching log`, `## Session summary`. If `teach-config.md`'s `extra_frontmatter`
or `extra_tags` are set, merge them in — see `STORAGE.md`. Merge rules: a skill-owned key (`id`,
`type`, `subject`, `status`, `created`, `updated`, `phase`, `node`, `revisit_on`, `retention_target`,
`tags`) always wins over a colliding `extra_frontmatter` key; `extra_tags` are de-duplicated against
the skill's own tags; files that already exist keep their existing frontmatter unchanged.

## The teach log

`$LOG` - append-only, one row per scored item, appended in a batch at session end. Create it from
`${CLAUDE_SKILL_DIR}/templates/teach-log.md` if it does not exist yet. Never rewrite an existing row.

`| Date | Subject | Session | Item | P | Outcome | Score |`

`Session` is the note's file stem (`<YYYY-MM-DD>-<topic-slug>`), written as a wikilink
(`[[<stem>]]`) only on the Obsidian backend; plain text on the plain-files backend.

Read calibration **per subject**, never as one pooled number (PROTOCOL rule 10). Note also that a
four-option item has a ~25% chance floor, so these Brier scores are not on the same scale as free-form
forecasting and should not be pooled with any such log you keep elsewhere.

## The learn index

`learn/index.md`, `type: overview` - a table of every session by subject with its status and
`revisit_on` date. A row is added when the session note is created in PROBE, and updated at every
phase change and at close - never only at the end. It is what makes `--due` and cross-subject
interleaving possible. If it does not exist, create it from
`${CLAUDE_SKILL_DIR}/templates/learn-index.md`, with this row shape:

`| Session | Subject | Status | Nodes | Brier | Revisit on |`

Column semantics: `Status` holds the note's `phase` (not a separate value); `Nodes` is
`<covered>/<total>`, or `-` before PLAN has emitted the DAG; `Brier` is the session's running mean;
`Revisit on` is the ISO date from `revisit_on`, or `-` while still open.

## Running --due

Read `learn/index.md` and find every row whose `revisit_on` is on or before today. If none are due,
say so and stop. Otherwise offer a short re-quiz drawn from each session's recorded item rows -
interleaved across subjects when more than one is due. Append the new rows to `$LOG`, reusing the
original `Session` value, and push each note's `revisit_on` out per PROTOCOL rule 9 using that
note's own `retention_target`. Bump `updated` and rewrite that session's row in `learn/index.md`. On
the Obsidian backend, every one of these writes goes through the CLI, as in `STORAGE.md`.

## A note on models

Teaching quality tracks model intelligence more than it tracks any instruction in this file. Run
`/teach` on the strongest model available to you, and switch with `/model` **before** invoking it. A
`model:` line in this file's frontmatter would not do that — it applies to one turn, not to the
session — and the quiz cannot be delegated to a subagent on a stronger model, because subagents cannot
ask the learner anything. So the switch is manual. If the session is running on a smaller model, say
so once at the start rather than quietly teaching worse.
