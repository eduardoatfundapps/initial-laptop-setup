#!/usr/bin/env bash
# Idempotent: installs oh-my-zsh and symlinks the repo's .zshrc into $HOME.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for repo in zsh-autosuggestions zsh-syntax-highlighting zsh-completions; do
  [ -d "$ZSH_CUSTOM/plugins/$repo" ] || git clone --depth=1 "https://github.com/zsh-users/$repo" "$ZSH_CUSTOM/plugins/$repo"
done

# Back up a real (non-symlink) .zshrc before replacing it
if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi
ln -sfn "$REPO/zsh/.zshrc" "$HOME/.zshrc"

echo "Done. Open a new terminal or run: source ~/.zshrc"
