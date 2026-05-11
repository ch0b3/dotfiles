#!/bin/bash

set -eu

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

echo "=== dotfiles installer ==="
echo "Dotfiles dir: $DOTFILES_DIR"
echo ""

# ---------------------
# Symlink dotfiles
# ---------------------
echo "--- Linking dotfiles ---"
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitconfig.local.example" ]] && continue

    echo "  $f -> ~/$f"
    ln -snfv "$DOTFILES_DIR/$f" "$HOME/$f"
done

# ---------------------
# Link config files
# ---------------------
echo ""
echo "--- Linking config files ---"
mkdir -p "$HOME/.config"

if [ -d "$DOTFILES_DIR/config" ]; then
    for f in "$DOTFILES_DIR"/config/*; do
        name=$(basename "$f")
        echo "  config/$name -> ~/.config/$name"
        ln -snfv "$f" "$HOME/.config/$name"
    done
fi

# ---------------------
# Homebrew
# ---------------------
echo ""
echo "--- Setting up Homebrew ---"
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

echo "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
brew cleanup

# ---------------------
# Post-install hints
# ---------------------
echo ""
echo "=== Done! ==="
echo ""
echo "Next steps:"
echo "  1. Copy and edit local config files:"
echo "     cp $DOTFILES_DIR/.gitconfig.local.example ~/.gitconfig.local"
echo "     cp $DOTFILES_DIR/.zshrc.local.example ~/.zshrc.local"
echo ""
echo "  2. Restart your shell:  exec zsh"
