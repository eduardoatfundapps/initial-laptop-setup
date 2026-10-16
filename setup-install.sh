#!/usr/bin/env bash
command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

xargs -n1 brew install < brew-apps.txt

cp aerospace-config.toml "$(aerospace config --config-path)"
