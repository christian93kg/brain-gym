---
name: teach-storage
description: How /teach persists sessions - backend selection, vault-local config, and the Obsidian write path. Read by SKILL.md before the first write.
---

# Storage

`/teach` needs to persist six things across sessions. Any backend that provides them works.

| Operation | Why it exists |
|---|---|
| **Create** a session note at `learn/<YYYY-MM-DD>-<slug>.md` | one note per session |
| **Append** a section to a session note | the note grows as the session moves |
| **Read and update** its frontmatter (`phase`, `node`, `revisit_on`, `updated`) | resuming mid-session |
| **Find** notes whose `phase` is not `done` | what bare `/teach` resumes |
| **Append** rows to the log | the scored-item log |
| **Read and rewrite** `learn/index.md` | what `--due` and cross-subject interleaving read |

Both directories live under **`$TEACH_HOME`**, or the current working directory if that variable is
unset. Call that root **`$ROOT`** below. Starting templates for the index and the log are in
`templates/` next to this file; SKILL.md gives the absolute path.

**Backend is chosen deterministically, not by asking:** if `$ROOT/.obsidian/` exists, use the
Obsidian backend. Otherwise use the plain-files backend. Check once per session, before the first
write.

**Before the first write on either backend**, check whether `$ROOT` is inside a git work tree
(`git -C "$ROOT" rev-parse --is-inside-work-tree` prints `true`) and whether `learn` and `log` are
ignored there. `check-ignore -q` rejects more than one pathname, and matching a directory pattern
against a path that does not exist yet requires a trailing slash, so check each one separately:
`git -C "$ROOT" check-ignore -q learn/` and `git -C "$ROOT" check-ignore -q log/` (exit `0` means
ignored). If it is a work tree and either is not ignored, stop and tell the learner: sessions and
scores would be staged into that repository. Ask them to set `$TEACH_HOME` to a directory outside
any repository they push, or to add `learn/` and `log/` to that repository's `.gitignore`, and wait
for the answer.

---

## Vault-local config

Optional, either backend. If `$ROOT/teach-config.md` exists, read its frontmatter for
installation-specific overrides:

```
---
log_file: my-teach-log.md
extra_frontmatter:
  domain: study
extra_tags:
  - study
---
```

| Key | Applies to | Default if absent |
|---|---|---|
| `log_file` | filename under `log/` | `teach-log.md` |
| `extra_frontmatter` | added to every session note's frontmatter, and to the index and log when they are created from the templates | none |
| `extra_tags` | appended to `tags` on the same files | none |

Merge rules: an `extra_frontmatter` key that collides with a skill-owned key (`id`, `type`, `subject`,
`status`, `created`, `updated`, `phase`, `node`, `revisit_on`, `retention_target`, `tags`) is ignored -
the skill's value wins, because those keys are the session's state machine. `extra_tags` are
de-duplicated against the skill's own tags. Files that already exist keep their frontmatter. Any other
key in `teach-config.md` (`id`, `type`, `status`, ...) is that note's own metadata and is ignored.

A ready-to-copy version is `templates/teach-config.md` next to this file. If the file is absent, every
default applies unchanged.

---

## Default backend - plain files

Nothing to configure. The skill uses the ordinary Write, Edit and Grep tools.

```bash
# create          -> Write learn/2026-08-21-differential-forms.md
# append          -> Edit, adding to the end of the file
# update a field  -> Edit the frontmatter line in place
# rewrite index   -> Write learn/index.md with the changed row

# find unfinished sessions (safe when learn/ is empty or missing)
grep -rlE --include='*.md' '^phase: (probe|plan|teach)$' learn 2>/dev/null || true
```

The most recent session is the greatest filename; every session file starts with its date. The Grep
tool (pattern `^phase: (probe|plan|teach)$`, path `learn`) is equivalent.

`learn/` and `log/` are gitignored in this repo by default, so a clone never publishes anyone's
sessions or scores. If you want your own history versioned, keep it in a **private** fork and remove
those two lines from `.gitignore`.

---

## Optional backend - Obsidian

For running `/teach` inside a synced Obsidian vault. Selected automatically when `$ROOT/.obsidian/`
exists. Requires the **official Obsidian CLI** (`obsidian`, ships with Obsidian 1.12+; enable it under
Settings → General → Command line interface; see <https://obsidian.md/help/cli>) and the app
**running** with the vault open - headless is fine. This is not the third-party `obsidian-cli` Go
tool, whose syntax differs.

**Use it instead of Write/Edit, not alongside.** A raw filesystem write into a synced vault folder
races Obsidian's own file watcher and sync engine. Reads are harmless - the Read and Grep tools are
fine on vault files - but **every write goes through the CLI**, including `learn/index.md` and the
log.

### Preflight - once, before the first write

```bash
timeout 20 obsidian vault info=path
```

It must print exactly `$ROOT` (resolved). If it prints anything else - an `Error:` line, nothing, or
the command times out - **stop and tell the learner**: Obsidian is not reachable from the CLI, so the
session cannot be saved safely; start Obsidian (or check `obsidian vault` in a shell) and run `/teach`
again. **Never fall back to Write/Edit inside a vault.** If more than one vault is open, add
`vault=<name>` to every command.

### How to read the CLI's output

The CLI **exits 0 even when it fails**, so check the text, not the exit code. The first line of
output tells you which case you are in:

| First line | Meaning |
|---|---|
| `Error: ...` | the command failed - nothing was written, or the file/property was not found |
| `No matches found.` | `search` ran and matched nothing; an empty result, not a failure |
| `=> ...` | the result of `eval` |

### Write path - stage, then `eval`

Stage every multi-line write as a file under `/tmp/teach-stage/` (outside the vault, with the Write
tool), then hand the CLI the *path*. Never put staged content into `content=`: by design the CLI turns
a literal backslash-n or backslash-t inside `content=` into a real newline or tab, and no escape
survives. `eval` with `readFileSync` does no such conversion and round-trips byte-exact.

```bash
mkdir -p /tmp/teach-stage

# create - fails with "Error: File already exists." rather than overwriting
obsidian eval code="app.vault.create('learn/2026-08-21-differential-forms.md', require('fs').readFileSync('/tmp/teach-stage/note.md','utf8')).then(f => f.path)"

# append a section - stage it starting with one empty line and ending with a newline
obsidian eval code="app.vault.append(app.vault.getAbstractFileByPath('learn/2026-08-21-differential-forms.md'), require('fs').readFileSync('/tmp/teach-stage/section.md','utf8')).then(() => 'appended')"

# rewrite a whole file (how an index row is updated): read it with the Read tool, Write the edited
# copy to the stage, then modify
obsidian eval code="app.vault.modify(app.vault.getAbstractFileByPath('learn/index.md'), require('fs').readFileSync('/tmp/teach-stage/index.md','utf8')).then(() => 'modified')"

# create a missing folder
obsidian folder path=learn          # "Error: Folder "learn" not found." -> create it:
obsidian eval code="app.vault.createFolder('learn').then(f => f.path)"
```

The trailing `.then(...)` is load-bearing: `eval` resolves a returned promise, but a resolved file
object cannot be serialised and prints `Error: Converting circular structure to JSON` **after the write
has already happened**. Always return a string. Single-quote the JavaScript strings, and keep
`/tmp/teach-stage/` paths free of quotes.

Inline `content=` is acceptable for one short line that contains no backslash and no double quote -
a single log row, for instance:

```bash
obsidian append path=log/teach-log.md content="| 2026-08-21 | mathematics | [[2026-08-21-differential-forms]] | grad of a scalar field | 0.70 | 1 | 0.09 |"
```

Anything longer, or a batch of rows, is staged.

### Frontmatter, reads, and finding sessions

```bash
obsidian property:read path=learn/2026-08-21-differential-forms.md name=phase
obsidian property:set  path=learn/2026-08-21-differential-forms.md name=phase value=teach
obsidian property:set  path=learn/2026-08-21-differential-forms.md name=node value=n4
obsidian property:set  path=learn/2026-08-21-differential-forms.md name=revisit_on value=2026-09-20 type=date
obsidian property:set  path=learn/2026-08-21-differential-forms.md name=updated value=2026-08-21 type=date

obsidian read path=learn/index.md    # adds a final newline if the file lacks one; otherwise byte-exact
obsidian read path=teach-config.md   # the vault-local config, if present

# finding unfinished sessions - bracket property syntax, one call per phase
obsidian search path=learn query="[phase:probe]" format=json
obsidian search path=learn query="[phase:plan]"  format=json
obsidian search path=learn query="[phase:teach]" format=json
```

`property:set` rewrites the frontmatter through the app and is the only way to touch it; give
`type=date` for date-valued keys. `search` prints a JSON array of paths, or `No matches found.`; the
most recent session is the greatest path. A bare `query="phase: teach"` fails with
`Error: Operator "phase" not recognized` - the colon is parsed as a search operator, so always use the
bracket form. After a `create`, allow a second before `search` sees the new note. `obsidian files`
filters with `folder=`, not `path=`.

### After writing

After any long write, read it back and confirm it matches the staged copy: `obsidian read path=...`
piped into `cmp - /tmp/teach-stage/<file>` (stage files with a trailing newline so the comparison is
exact). `obsidian delete path=...` moves a note to the trash and is reversible; the skill itself never
deletes.

**Obsidian ignores dot-folders** other than `.obsidian`, so a `.claude/` directory inside a vault will
not survive a resync. Keep the skill files outside the vault and symlink them in, or keep them in a
normal (non-dot) folder inside the vault and point `.claude/skills` at it with a symlink.
