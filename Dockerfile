FROM ubuntu:24.04

# update package index
RUN apt update

# neovim dependencies
RUN apt install -y build-essential cmake gettext git

# install neovim
RUN git clone https://github.com/neovim/neovim.git
RUN cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo &&make install

# telescope dependencies
RUN apt install ripgrep fd-find

# LSP dependencies
# mason requires system python with venv capabilities
RUN apt install -y python3.12-venv
# terraform needs unzip
RUN apt install -y zip
# pyright needs npm
RUN apt install -y npm
# latex needs tree-sitter-cli
RUN npm install -g tree-sitter-cli
# gopls needs go
RUN apt install -y wget
RUN rm -rf /usr/local/go && \
    wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

# pyenv
RUN apt install -y zlib1g-dev libbz2-dev libncurses5-dev libncursesw5-dev libffi-dev libreadline-dev libssl-dev libsqlite3-dev liblzma-dev
RUN curl https://pyenv.run | bash
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    . ~/.bashrc && \
    pyenv install 3.10.14 && \
    pyenv global 3.10.14

# neovim config
RUN git clone https://github.com/dgarridoa/nvim-config && mkdir ~/.config && mv nvim-config ~/.config/nvim
