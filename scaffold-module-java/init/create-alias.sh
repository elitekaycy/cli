#!/bin/bash

# Get the absolute path of scaffold.sh relative to the current directory
SCRIPT_PATH=$(realpath ../scaffold.sh)

# Add alias to .bashrc and .zshrc
for SHELL_RC in ~/.bashrc ~/.zshrc; do
  if ! grep -q "alias scaffold=" "$SHELL_RC"; then
    echo "alias scaffold='bash $SCRIPT_PATH'" >> "$SHELL_RC"
    echo "Alias added to $SHELL_RC."
  else
    echo "Alias already exists in $SHELL_RC."
  fi
done

# Reload shell configuration
source ~/.bashrc 2>/dev/null
source ~/.zshrc 2>/dev/null

echo "Alias setup complete. Use 'scaffold' to scaffold projects."

