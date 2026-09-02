#!/usr/bin/env bash
# Install /teach and the fact-check agent into ~/.claude by symlink, so that
# `git pull` in this repo updates them in place.
#
#   bash install.sh              install
#   bash install.sh --force      replace whatever is already there
#   bash install.sh --uninstall  remove the symlinks (only if they point here)

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

FORCE=0
UNINSTALL=0
for arg in "$@"; do
  case "$arg" in
    --force)     FORCE=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   sed -n '2,7p' "${BASH_SOURCE[0]}" | sed 's/^# \?//'; exit 0 ;;
    *)           echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

# resolve <path> -- print an absolute, symlink-resolved path.
# Prefer `readlink -f` (GNU/most Linux); fall back to a portable cd+pwd -P
# form for shells where it's unavailable (e.g. BSD/macOS readlink).
if readlink -f . >/dev/null 2>&1; then
  resolve() { readlink -f "$1"; }
else
  resolve() { ( cd "$(dirname "$1")" && printf '%s/%s\n' "$(pwd -P)" "$(basename "$1")" ); }
fi

# link <source-in-repo> <destination-in-~/.claude>
link() {
  local src="$REPO/$1" dst="$CLAUDE/$2" bak

  if [ ! -e "$src" ]; then
    echo "  missing in repo: $1" >&2
    return 1
  fi

  if [ "$UNINSTALL" -eq 1 ]; then
    if [ -L "$dst" ] && [ "$(resolve "$dst")" = "$(resolve "$src")" ]; then
      rm "$dst"; echo "  removed  $dst"
    else
      echo "  skipped  $dst (not a symlink into this repo)"
    fi
    return 0
  fi

  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ -L "$dst" ] && [ "$(resolve "$dst")" = "$(resolve "$src")" ]; then
      echo "  ok       $dst (already linked)"
      return 0
    fi
    if [ "$FORCE" -eq 0 ]; then
      echo "  EXISTS   $dst -- leaving it alone. Re-run with --force to replace." >&2
      return 1
    fi
    bak="$dst.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$bak"
    echo "  backed up $dst -> $bak"
  fi

  ln -s "$src" "$dst"
  echo "  linked   $dst -> $src"
}

status=0
link "skills/teach"          "skills/teach"          || status=1
link "agents/fact-check.md"  "agents/fact-check.md"  || status=1

if [ "$UNINSTALL" -ne 1 ]; then
  if [ ! -e "$CLAUDE/skills/teach/templates/learn-index.md" ]; then
    echo "  warning: templates not reachable via $CLAUDE/skills/teach" >&2
    status=1
  fi
fi

if [ "$UNINSTALL" -eq 1 ]; then
  echo "Uninstalled."
  exit "$status"
fi

if [ "$status" -ne 0 ]; then
  echo
  echo "Some links were not created. Nothing was overwritten." >&2
  exit 1
fi

cat <<EOF

Installed. Start Claude Code in the directory you want sessions saved under
and run:

    /teach the Monty Hall problem

Sessions are written to ./learn and ./log in whatever directory you run from,
or under \$TEACH_HOME if you set it. Both are gitignored here by default.

Running inside an Obsidian vault? Read skills/teach/STORAGE.md first.
EOF
