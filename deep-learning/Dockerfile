FROM nvcr.io/nvidia/pytorch:20.03-py3

RUN apt-get update
RUN apt-get install -y vim screen htop rsync gcc make pkg-config autoconf automake python3-docutils libseccomp-dev libjansson-dev libyaml-dev libxml2-dev

# Nvtop
RUN git clone https://github.com/Syllo/nvtop.git && mkdir -p nvtop/build && cd nvtop/build && cmake .. && make && make install & cd ../..

RUN conda install scipy numpy pandas psycopg2
RUN pip install ax-platform ray[tune] tqdm mlflow dask[complete] awscli boto3 tensorboardX learn2learn petname

RUN export MLFLOW_TRACKING_URI="http://0.0.0.0:5000" >> /root/.bashrc
