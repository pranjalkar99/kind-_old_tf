FROM shridharkini6/ubuntu14_cuda8_cudann5_all_prerequisites
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
ENV TF_BINARY_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-1.14.0-cp36-none-linux_x86_64.whl"




RUN apt-get install -y gcc-4.8
RUN apt-get update || echo "Error Occurred!"
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget --no-check-certificate \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version


RUN conda --version
RUN conda create -y --name iedit python=3.6

RUN conda run -n iedit conda install tensorflow-gpu
# RUN conda run -n iedit pip install --ignore-installed --upgrade ${TF_BINARY_URL}
RUN conda run -n iedit pip install cython

RUN conda run -n iedit pip install numpy==1.21.6 Pillow==9.3.0 scipy==1.9.3 scikit-image==0.19.3

RUN apt-get update || echo "Error Occurred!"
RUN apt-get install -y libglib2.0-0 \
    && apt install -y libsm6 libxext6 \
    && apt-get install -y libxrender-dev
RUN conda run -n iedit conda install -c conda-forge unzip

ADD ./KinD_plus /root/legacy_data/KinD_plus


RUN conda init bash
RUN echo "conda activate iedit" >> ~/.bashrc
RUN echo "export PYTHONPATH=$PYTHONPATH" >> ~/.bashrc
# SHELL ["/bin/bash", "-c"]
# WORKDIR /root/legacy_data/hdrnet_unofficial/hdrnet
# RUN conda run -n iedit make