# Contributing

## Proposing a change

`PROTOCOL.md` is the load-bearing file. A change to a rule needs a change to the claim behind it,
so open an issue with the evidence before the pull request — a rule without a citation in
`EVIDENCE.md` is a rule this project won't keep.

Bug reports and clarity fixes need no ceremony. Open a PR.

## Style

- Markdown wrapped at roughly 100 columns.
- Shell scripts: `set -euo pipefail`, shellcheck-clean (`shellcheck -s bash`), and portable to
  macOS's bash 3.2 (no `mapfile`, no associative arrays, no `${var,,}`).
- `PROTOCOL.md` rules cite `EVIDENCE.md` claim ids with a source, a confidence, and a date.
- New claims in `EVIDENCE.md` carry an assertion, a real source, a confidence level, and a
  verification date. `unverifiable` is an acceptable answer; an invented citation is not.

## One thing to keep in mind

`learn/` and `log/` are gitignored, and the tutor refuses to write sessions into a repository
where they aren't. Please don't paste real session notes or scored items into an issue or a
commit — use the fictional `differential forms` session in the README if you need an example.
