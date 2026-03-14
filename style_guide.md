## Shell Script Styling Pattern

### Color Palette

Define ANSI colors at the top, after `set -euo pipefail`:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'
```

### Log Functions

Three terse one-liner log functions using a `::` prefix as the visual marker (inspired by Arch Linux's `pacman`). The `::` takes the semantic color; the message text is uncolored:

```bash
info()  { echo -e "${CYAN}::${RESET} $*"; }
warn()  { echo -e "${YELLOW}::${RESET} $*"; }
good()  { echo -e "${GREEN}::${RESET} $*"; }
```

- **`info`** (cyan `::`) — neutral status updates, skipped items, instructions
- **`warn`** (yellow `::`) — things that need attention but aren't errors
- **`good`** (green `::`) — successful operations, confirmations

Errors use inline `${RED}` rather than a dedicated function (they typically `exit` right after).

### When to Use `${BOLD}` Inline

Bold is used **within** log messages to highlight the key noun — usually a filename or repo URL — while keeping the surrounding text normal weight:

```bash
info "Cloning ${BOLD}$GITHUB_REPO${RESET} into $CLONE_DIR ..."
info "${BOLD}Syncing files ...${RESET}"
good "${BOLD}Done!${RESET} Changes applied to ~/dotfiles."
```

### Diff/Change Headers

When showing a file with differences, use yellow+bold for the filename as a section header, followed by a blank line before the diff output:

```bash
echo -e "${YELLOW}${BOLD}$file${RESET} has differences:"
echo
```

### Interactive Prompts

Prompts are indented with 2 spaces, options listed on one line with brackets, input on the same line via `echo -n`:

```bash
echo "  [s]kip  [a]ccept github version  [m]erge in vimdiff  [p]atch (hunk-by-hunk)"
echo -n "  Choice [s/a/m/p]: "
```

For yes/no prompts, use `[y/N]` or `[Y/n]` convention with 2-space indent:

```bash
echo -n "  Copy from GitHub? [y/N] "
```

### Outcome Messages

After an action completes, report it with `good` using the format `filename: what happened`:

```bash
good "$file: replaced with GitHub version"
good "$file: merged"
good "$rel_path: copied and added to sync config"
```

### Section Separators

Use blank `echo` lines between logical sections (after clone, before/after the file walk, before the summary). Use `# --- section name ---` comments to label major blocks in the source.

### Summary Block

End with a conditional summary. If changes were made, show bold "Done!" via `good` followed by indented next-steps. If no changes, a simple `info` one-liner:

```bash
if $changes_made; then
    good "${BOLD}Done!${RESET} Changes applied to ~/dotfiles."
    echo
    echo "  Next steps:"
    echo "    1. Review:  diff ~/dotfiles/"
    echo "    2. Sync:    dotsync2 push"
    echo "    3. Source:   source ~/.zshrc"
else
    info "No changes made."
fi
```

### TL;DR for an Agent

1. Colored `::` prefix for all log lines (cyan=info, yellow=warn, green=success, inline red=error)
2. `${BOLD}` on the key noun in a message, not the whole line
3. `# --- label ---` comment separators between sections
4. 2-space indented prompts with bracketed options
5. Outcome messages follow `filename: action taken` pattern
6. Blank lines between logical sections for breathing room
7. Conditional summary at the end with indented next-steps
