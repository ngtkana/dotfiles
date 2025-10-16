#!/bin/bash

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== zsh dotfiles installer ==="
echo "Script directory: $SCRIPT_DIR"

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
    echo "Error: zsh is not installed. Please install zsh first."
    echo "On macOS: brew install zsh (if not already default)"
    echo "On Ubuntu: sudo apt install zsh"
    exit 1
fi

# Check if zsh is the default shell
if [[ "$SHELL" != */zsh ]]; then
    echo "Warning: zsh is not your default shell."
    echo "Current shell: $SHELL"
    echo "To change default shell to zsh, run: chsh -s $(which zsh)"
    echo ""
fi

# .zshrc - only add source line if it doesn't already exist
ZSHRC_MARKER="# dotfiles-zsh-install-marker"
if ! grep -Fq "$ZSHRC_MARKER" ~/.zshrc 2>/dev/null; then
    echo "Adding zshrc source line..."
    echo "" >> ~/.zshrc
    echo "$ZSHRC_MARKER" >> ~/.zshrc
    echo "source $SCRIPT_DIR/config/zshrc_base.zsh" >> ~/.zshrc
else
    echo "zshrc source line already exists, skipping..."
fi

# Function to create symbolic link safely
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    if [ -L "$target" ]; then
        # If it's already a symlink, check if it points to the right place
        if [ "$(readlink "$target")" = "$source" ]; then
            echo "Symlink $target already exists and is correct, skipping..."
            return 0
        else
            echo "Removing incorrect symlink $target..."
            rm "$target"
        fi
    elif [ -e "$target" ]; then
        # If target exists but is not a symlink, back it up
        echo "Backing up existing file $target to $target.backup..."
        mv "$target" "$target.backup"
    fi
    
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Create symbolic links (same as bash version)
echo "Setting up symbolic links..."
create_symlink "$SCRIPT_DIR/config/nvim" ~/.config/nvim
create_symlink "$SCRIPT_DIR/config/cargo_config.toml" ~/.cargo/config.toml
create_symlink "$SCRIPT_DIR/config/starship.toml" ~/.config/starship.toml
create_symlink "$SCRIPT_DIR/config/stylua.toml" ~/.stylua.toml
create_symlink "$SCRIPT_DIR/config/tmux.conf" ~/.tmux.conf

echo ""
echo "=== Installation complete! ==="
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. If zsh is not your default shell, run: chsh -s \$(which zsh)"
echo "3. Install recommended tools if not already installed:"
echo "   - starship: curl -sS https://starship.rs/install.sh | sh"
echo "   - direnv: brew install direnv (macOS) or apt install direnv (Ubuntu)"
echo ""
echo "Enjoy your new zsh configuration! 🚀"
