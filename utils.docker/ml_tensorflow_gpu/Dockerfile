FROM ml-thushv89:latest

LABEL maintainer="Thushan Ganegedara"

USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND=noninteractive

RUN wget -q http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb

RUN dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb \
 && apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && apt-get update \
 && apt-get install -yq --no-install-recommends cuda \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir tensorflow-gpu

EXPOSE 8888

# Setup work directory for backward-compatibility
# RUN chown $NB_UID:$NB_GID $HOME && chmod g+rwX $HOME

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

