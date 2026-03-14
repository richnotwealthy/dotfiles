# CLAUDE.md

Portable dotfiles for new machines. Dracula theme throughout.

## Repo structure

- `zshrc.zsh` — zsh config (plugins, aliases, functions)
- `theme.zsh` — two-line prompt with git and hg support
- `vimrc.vim` — vim config with vim-plug
- `tmux.conf` — tmux config (prefix is C-a)
- `scripts/install` — main installer: deps, oh-my-zsh, symlinks, shell defaults, git identity
- `scripts/install-tools` — optional extras: Eternal Terminal, fnm/Node.js, Claude Code
- `scripts/cloud-init.sh` — cloud instance bootstrap (not executable, piped via cloud-init)
- `scripts/banner.zsh` — login banner (cowsay or starfield)
- `terminals/` — terminal emulator configs (iTerm, Terminator)
- `references/style.md` — shell script style guide

## Shell script conventions

Follow `references/style.md` for all shell scripts:
- `set -euo pipefail` at the top
- Color palette and log functions: `info`, `warn`, `good`, `error`
- `# --- section name ---` comment separators
- `${BOLD}` on key nouns in log messages, not entire lines
- Outcome messages: `filename: action taken`
- Use `command -v` not `which`
- Quote variables: `"$var"` not `$var`

## Key details

- The user uses both git and Mercurial (hg at work) — do not remove hg support
- `install` preserves machine defaults from existing `.zshrc`/`.bashrc` into `.zshrc.defaults`
- vim mappings use `nnoremap` (not `map`) unless intentionally chaining into `<Plug>` mappings
