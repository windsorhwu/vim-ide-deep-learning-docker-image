FROM nvcr.io/nvidia/pytorch:20.01-py3

RUN apt-get update
RUN apt-get install -y vim screen htop

RUN conda install scipy numpy pandas
RUN pip install ax-platform ray tqdm mlflow dask[complete] fastparquet awscli boto3

RUN echo set -o vi >> /root/.bashrc && \
    echo export VISUAL=vim >> /root/.bashrc && \
    echo export EDITOR=vim >> /root/.bashrc

# Vim setup
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc /root/.vimrc
RUN vim +PluginInstall +qall
COPY vim_additions /root/vim_additions
RUN cat /root/vim_additions >> /root/.vimrc
RUN rm /root/vim_additions 
COPY TabNine /root/.config/TabNine

RUN rm -rf /workspace
WORKDIR /workspace

