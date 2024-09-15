.PHONY: update anki nvim vim_defaults starship zsh_plugins

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
	sudo rm -rf /opt/anki
	tag=$$(curl -s https://api.github.com/repos/ankitects/anki/releases/latest | jq -r '.tag_name'); \
	curl -LO https://github.com/ankitects/anki/releases/download/"$$tag"/anki-"$$tag"-linux-qt6.tar.zst; \
	tar -xaf anki-"$$tag"-linux-qt6.tar.zst; \
	rm anki-"$$tag"-linux-qt6.tar.zst; \
	sudo mv anki-"$$tag"-linux-qt6 /opt/anki/;
	sudo chown -R root:root /opt/anki
	cd /opt/anki && sudo ./install.sh

nvim: update
	sudo apt install make gcc ripgrep unzip git xclip curl
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

starship:
	curl -sS https://starship.rs/install.sh | sh

zsh_plugins:
	./scripts/zsh_plugins.sh
