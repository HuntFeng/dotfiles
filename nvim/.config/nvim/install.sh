#!/bin/bash
# run this script as root

# xclip for system clipboard
# ripgrep for searching
# python for some language servers
# n for nodejs and npm (for some language servers)
apt-get update \
&& apt-get install -y xclip \
&& apt-get install -y ripgrep \
&& apt-get install -y python3 python3-pip python3-venv \
&& curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s install lts \
&& cd /opt \
&& wget https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz \
&& mkdir nvim \
&& tar -xzvf nvim-linux-x86_64.tar.gz -C nvim --strip-components=1 \
&& ln -s /opt/nvim/bin/nvim /usr/bin/nvim \
&& rm -rf /opt/nvim-linux-x86_64.tar.gz

