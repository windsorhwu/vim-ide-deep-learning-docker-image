###
# Installs a full featured Python 3 IDE.
# The base image must have Python 3 and pip installed and in path.
# Comment out the TabNine portion if not applicable.
###

FROM deep-learning

WORKDIR /root

RUN apt-get update
RUN apt-get install -y vim
RUN pip install black flake8 python-language-server

# Flake8 compatability with Black.
RUN mkdir /root/.config
RUN printf "[flake8]\nmax-line-length=88\nextend-ignore=E203" >> /root/.config/flake8

# Make vim first class.
RUN echo set -o vi >> /root/.bashrc && \
    echo export VISUAL=vim >> /root/.bashrc && \
    echo export EDITOR=vim >> /root/.bashrc

# Install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc /root/.vimrc

# Install plugins
RUN vim +PluginInstall +qall
COPY vim_additions /root/vim_additions
RUN cat /root/vim_additions >> /root/.vimrc
RUN rm /root/vim_additions 

# Setup TabNine configs. Make sure the config and model are accessible.
COPY TabNine /root/.config/TabNine
COPY b8373e4b.tabninemodel /root/.local/share/TabNine/models/b8373e4b.tabninemodel

# Ctags setup.
RUN apt-get update
RUN apt-get install build-essential autoconf automake libtool
RUN git clone https://github.com/universal-ctags/ctags.git
RUN cd ctags && ./autogen.sh && ./configure && make && make install

# Index libraries in path.
# See https://www.fusionbox.com/blog/detail/navigating-your-django-project-with-vim-and-ctags/590/
RUN ctags -R --fields=+l --languages=python --python-kinds=-iv -f /root/tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
RUN echo set tags=/root/tags >> /root/.vimrc
