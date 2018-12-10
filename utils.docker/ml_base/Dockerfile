FROM ubuntu:16.04

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"
ARG NB_USER="testuser"
ARG NB_UID="1000"
ARG NB_GID="100"
ARG GPU_SUPPORT="0"

USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    wget \
    ca-certificates \
    sudo \
	vim-tiny \
	python3-dev \
	python3-pip \   
	python3-setuptools \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir jupyter \
	numpy pandas matplotlib \
	scikit-learn scipy

# Configure environment
ENV SHELL=/bin/bash  
ENV NB_USER=$NB_USER 
ENV NB_UID=$NB_UID 
ENV NB_GID=$NB_GID
    
ENV HOME=/home/$NB_USER

# Create jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN groupadd wheel -g 11 && \
	groupmod users -g $NB_GID && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    useradd -m -l -s /bin/bash -N -u $NB_UID -g $NB_GID $NB_USER && \
    chmod g+w /etc/passwd && \
	chgrp $NB_GID $HOME && chmod g+rwX $HOME

USER $NB_UID

RUN mkdir /home/$NB_USER/work && \
    chgrp $NB_GID $HOME && chmod g+rwX $HOME

USER root

EXPOSE 8888
WORKDIR $HOME

# Configure container startup
# Depricated: Since Docker 1.13 tini can be invoked simply using --init at docker runs
# Docker container is a PID namespace, meaning containers processes are formed as a tree, 
# where whatever you set as the ENTRYPOINT will be the init process (process with PID=1)
# This init process is supposed to take care of zombies (childress processes left behind due to bad parenting)
# (e.g. not "wait"ed by the parent process when parent exits). These children are reparented to init, which will
# reap these zombie processes
# More info: https://github.com/krallin/tini/issues/8
# ENTRYPOINT ["tini", "-g", "--"]

# Add local files as late as possible to avoid cache busting

COPY jupyter_notebook_config.py /etc/jupyter/
RUN chgrp $NB_GID /etc/jupyter/ && chmod g+rwX /etc/jupyter/

# Setup work directory for backward-compatibility
RUN chown $NB_UID:$NB_GID $HOME && chmod g+rwX $HOME

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

