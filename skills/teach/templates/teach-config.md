---
log_file: teach-log.md
extra_frontmatter:
  domain: learning
extra_tags:
  - learning
---

# teach-config

Optional. Copy this file to the directory you run `/teach` from (`$TEACH_HOME`, or the current
directory — the same root that holds `learn/` and `log/`) and edit the frontmatter:

- `log_file` — filename under `log/` for the scored-item log. Default `teach-log.md`.
- `extra_frontmatter` — keys merged into every session note's frontmatter (and into the index and
  log when they are created from the templates), e.g. a taxonomy key your vault already uses.
  Default none.
- `extra_tags` — appended to every session note's and the log's tags. Default none.

Delete any key you do not need; absent keys fall back to the defaults. At this repo's root the file
is gitignored, so an installation's conventions never end up in a commit. Full reference:
`STORAGE.md` next to the skill, "Vault-local config".
