.PHONY: update anki nvim vim_defaults tree_sitter_cli zsh_plugins

update:
	sudo apt update

sync:
	rsync \
		--exclude ".git/" \
		--exclude ".idea/" \
		--exclude "docs/" \
		--exclude "scripts" \
		--exclude ".editorconfig" \
		--exclude ".gitignore" \
		--exclude ".gitmodules" \
		--exclude "bootstrap.sh" \
		--exclude "dotfiles.iml" \
		--exclude "Makefile" \
		--exclude "README.md" \
		-avh . ~

anki: update
	sudo apt install libxcb-xinerama0 libxcb-cursor0 libnss3 zstd
	tag=$$(curl -s https://api.github.com/repos/ankitects/anki/releases/latest | jq -r '.tag_name'); \
	curl -LO https://github.com/ankitects/anki/releases/download/"$$tag"/anki-launcher-"$$tag"-linux.tar.zst; \
	tar -xaf anki-launcher-"$$tag"-linux.tar.zst; \
	cd anki-launcher-"$$tag"-linux && sudo ./install.sh; \
	cd .. && rm -r anki-launcher-"$$tag"-linux{,.tar.zst}

nvim: update tree_sitter_cli
	sudo apt install make gcc ripgrep unzip git curl
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo mkdir -p /opt/nvim-linux-x86_64
	sudo chmod a+rX /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo chown -R root:root /opt/nvim-linux-x86_64
	sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
	rm nvim-linux-x86_64.tar.gz

vim_defaults:
	mkdir -p ~/.vim
	vim --clean +'silent! !cp "$$VIMRUNTIME/defaults.vim" ~/.vim/' +'qa!'

tree_sitter_cli:
	npm install -g tree-sitter-cli

zsh_plugins:
	./scripts/zsh_plugins.sh
