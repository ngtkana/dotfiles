#!/bin/bash

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# .bashrc - only add source line if it doesn't already exist
BASHRC_MARKER="# dotfiles-install-marker"
if ! grep -Fq "$BASHRC_MARKER" ~/.bashrc 2>/dev/null; then
    echo "Adding bashrc source line..."
    echo "" >> ~/.bashrc
    echo "$BASHRC_MARKER" >> ~/.bashrc
    echo "source $SCRIPT_DIR/config/bashrc_base.bash" >> ~/.bashrc
else
    echo "bashrc source line already exists, skipping..."
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

# Create symbolic links
echo "Setting up symbolic links..."
create_symlink "$SCRIPT_DIR/config/nvim" ~/.config/nvim
create_symlink "$SCRIPT_DIR/config/cargo_config.toml" ~/.cargo/config.toml
create_symlink "$SCRIPT_DIR/config/starship.toml" ~/.config/starship.toml
create_symlink "$SCRIPT_DIR/config/stylua.toml" ~/.stylua.toml
create_symlink "$SCRIPT_DIR/config/tmux.conf" ~/.tmux.conf

echo "Installation complete!"
