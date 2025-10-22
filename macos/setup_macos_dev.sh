#!/usr/bin/env bash
set -euo pipefail

echo ">>> Ensuring your shell is zsh..."
if [[ "$SHELL" != *"zsh" ]]; then
  chsh -s /bin/zsh
  echo "Default shell changed to zsh. You may need to restart Terminal."
fi

echo ">>> Installing missing CLI tools..."
brew install zoxide fzf ripgrep fd bat eza jq gh zellij git-delta || true

# Enable fzf key bindings & completion without modifying rc files
yes | "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc >/dev/null

ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

echo ">>> Updating ~/.zshrc ..."

add_line() {
  local line="$1"
  grep -qxF "$line" "$ZSHRC" 2>/dev/null || echo "$line" >> "$ZSHRC"
}

# Homebrew shellenv
add_line '# Homebrew environment'
add_line 'eval "$($(brew --prefix)/bin/brew shellenv)"'

# fzf setup
add_line ''
add_line '# fzf setup'
add_line "[ -f \"$(brew --prefix)/opt/fzf/shell/completion.zsh\" ] && source \"$(brew --prefix)/opt/fzf/shell/completion.zsh\""
add_line "[ -f \"$(brew --prefix)/opt/fzf/shell/key-bindings.zsh\" ] && source \"$(brew --prefix)/opt/fzf/shell/key-bindings.zsh\""

# zoxide init + zi command
add_line ''
add_line '# zoxide init and zi helper'
add_line 'eval "$(zoxide init zsh)"'
add_line 'zi() { cd "$(zoxide query -i)" || return; }'

# fzf defaults using ripgrep and fd
add_line ''
add_line '# fzf defaults'
add_line 'export FZF_DEFAULT_COMMAND='\''rg --files --hidden --follow --glob "!.git"'\'''
add_line 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"'
add_line 'export FZF_ALT_C_COMMAND='\''fd --type d --hidden --follow --exclude .git'\'''

# Quality-of-life aliases
add_line ''
add_line '# Aliases'
add_line 'alias ls="eza -lah --group-directories-first"'
add_line 'alias cat="bat -pp"'
add_line 'alias grep="rg"'
add_line 'alias ..="cd .."'
add_line 'alias ...="cd ../.."'
add_line 'alias gs="git status -sb"'
add_line 'alias gl="git log --oneline --graph --decorate -20"'
add_line 'alias gd="git diff"'
add_line 'alias gb="git branch -vv"'
add_line 'alias v="code ."'

# Git defaults
add_line ''
add_line '# Git defaults'
add_line 'git config --global color.ui auto'
add_line 'git config --global init.defaultBranch main'
add_line 'git config --global pull.ff only'
add_line 'git config --global core.pager "delta"'
add_line 'git config --global interactive.diffFilter "delta --color-only"'
add_line 'git config --global delta.navigate true'
add_line 'git config --global delta.line-numbers true'

echo ">>> Reloading zsh configuration..."
if [[ "$SHELL" == *"zsh"* ]]; then
  source "$ZSHRC"
fi

cat <<'EOF'

Setup complete!

✅ Default shell: zsh
✅ zoxide + fzf + zi shortcuts ready
✅ Aliases and Git enhancements applied
✅ Tools installed: zoxide, fzf, rg, fd, bat, eza, gh, jq, zellij, delta

Try these:
  zi               -> fuzzy jump to a recent directory
  z <keyword>      -> instant jump
  Ctrl+R           -> fuzzy search command history
  eza / bat / rg   -> fast replacements for ls, cat, grep

Restart Terminal if any changes don't appear immediately.
EOF

