# Deep Research Prompt Framework

This is the prompt shape the research passes summarised in [`EVIDENCE.md`](EVIDENCE.md) were
commissioned with; it is included so those claims can be re-derived or extended with the same rigour.

Use this shape whenever drafting a prompt to hand to a separate research session — a GUI/deep-research
tool with no access to your other files, vaults, or prior conversation context.

## Container conventions

- Keep the prompt as one self-contained, copy-pasteable block — plain text, no formatting that won't
  survive a paste.
- Above the block: one short paragraph stating what this prompt is for, what prior research (if any)
  it builds on, and what it deliberately excludes.
- Below the block: a placeholder for where the returned output goes, and what happens to it next
  (e.g. "paste results here, then extract into atomic facts").

## Internal structure of the prompt itself

**ROLE** — one line. What kind of analyst/expert the researcher should act as, plus a hard scope
fence: state explicitly what NOT to cover if it's a separate question for later.

**GIVEN** — the self-contained fact base. The research session has no access to anything else, so
every fact it needs to reason from must be spelled out here: your situation, constraints, prior
conclusions already reached. Explicitly mark anything "already settled — do not re-derive" so a
follow-up prompt doesn't waste effort re-answering a solved question or, worse, contradict it.

**HARD REQUIREMENTS** — stakes-gated: include for legal/medical/financial/high-consequence topics,
omit for low-stakes ones (e.g. shopping shortlists).

- Primary sources only for load-bearing claims; name what counts as primary (statutes, court
  decisions, official regulator pages) vs. secondary (blogs, forums — allowed only as orientation,
  clearly labeled).
- An explicit confidence level (high/medium/low) per finding, with a stated reason when it isn't high.
- Explicit flags for anything unverifiable, anything where sources conflict, and anything that's the
  researcher's own inference rather than a sourced fact.

**PART 1…N** — break the topic into numbered, independently answerable questions. Each part should
state what it does *not* re-ask, so a topic can be split across multiple sequential prompts (a first
pass, then narrow follow-ups) without overlap or duplicated research spend.

**OUTPUT** — specify the deliverable shape explicitly:

1. A short BLUF/summary answer up front.
2. Findings per PART, each labeled, sourced, with a confidence level.
3. Explicit flags for anything unresolved or conflicting.
4. A clean source list, grouped by which PART it supports.

## Why each piece exists

- **GIVEN + explicit exclusions** — the research session has zero memory of your other context;
  anything unstated gets re-derived (wasting the run) or guessed (introducing errors that contradict
  what you already know).
- **Stakes-gated HARD REQUIREMENTS** — forcing primary-source rigor onto a "which cars should I look
  at" prompt is wasted overhead; omitting it from a legal/medical question is negligent. Match the bar
  to the consequence of being wrong.
- **Numbered PARTs with explicit non-overlap** — lets you commission a first broad pass, then narrow,
  sourced follow-ups later without re-litigating what's already answered — mirrors how real research
  programs sequence.
- **Explicit OUTPUT spec** — the researcher can't infer your downstream use. If you need sourced
  claims with confidence levels to feed into a decision, say so — otherwise you get generic prose
  that's hard to extract facts from.

## Quick template

```
ROLE: [type of analyst]. [What's explicitly out of scope and why.]

GIVEN:
- [Fact 1 about your situation/constraints]
- [Fact 2]
- [Prior conclusion already reached — do not re-research]

HARD REQUIREMENTS: [only if stakes warrant]
- Primary sources only for load-bearing claims.
- State confidence (high/medium/low) per finding, with reason if not high.
- Flag conflicts, unverifiable claims, and inferences explicitly.

PART 1 — [specific question]. [What it does not re-ask.]
PART 2 — [specific question]. [What it does not re-ask.]
...

OUTPUT:
1. BLUF summary.
2. Findings per PART — labeled, sourced, confidence-rated.
3. Explicit unresolved/conflicting flags.
4. Source list grouped by PART.
```
