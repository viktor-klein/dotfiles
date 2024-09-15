#!/usr/bin/env bash

cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins || exit

plugin_urls=(
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for plugin_url in "${plugin_urls[@]}"; do
    plugin=$(basename "$plugin_url" .git)

    if [[ -d $plugin ]]; then
        echo Update "$plugin"...
        git -C "$plugin" pull
    else
        echo Clone "$plugin"...
        git clone "$plugin_url" "$plugin"
    fi
done
