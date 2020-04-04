FROM nvcr.io/nvidia/pytorch:19.10-py3

RUN apt-get update
RUN apt-get install -y vim screen htop rsync

RUN conda install scipy numpy pandas psycopg2
RUN pip install ax-platform ray ray[tune] tqdm mlflow dask[complete] fastparquet awscli boto3 black flake8 python-language-server tensorboardX


# Flake8 compatability with Black.
RUN printf "[flake8]\nmax-line-length = 88\nextend-ignore = E203" >> /root/.config/.flake8

# Vim bash setup.
RUN echo set -o vi >> /root/.bashrc && \
    echo export VISUAL=vim >> /root/.bashrc && \
    echo export EDITOR=vim >> /root/.bashrc && \
    export MLFLOW_TRACKING_URI="http://0.0.0.0:5000" >> /root/.bashrc

# Vim setup
# Install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc /root/.vimrc
# Install plugins
RUN vim +PluginInstall +qall
COPY vim_additions /root/vim_additions
RUN cat /root/vim_additions >> /root/.vimrc
RUN rm /root/vim_additions 
# Setup TabNine configs.
COPY TabNine /root/.config/TabNine
# Ctags setup.
RUN git clone https://github.com/universal-ctags/ctags.git
RUN apt-get install -y gcc make pkg-config autoconf automake python3-docutils libseccomp-dev libjansson-dev libyaml-dev libxml2-dev
RUN cd ctags && ./autogen.sh && ./configure && make && make install
# Index libraries in path.
# See https://www.fusionbox.com/blog/detail/navigating-your-django-project-with-vim-and-ctags/590/
RUN ctags -R --fields=+l --languages=python --python-kinds=-iv -f /root/tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
RUN echo set tags=/root/tags >> /root/.vimrc

# Remove the example projects and other temporary files.
RUN rm -rf /workspace

WORKDIR /root
