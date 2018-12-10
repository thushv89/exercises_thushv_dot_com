FROM ml-thushv89:latest

LABEL maintainer="Thushan Ganegedara"

USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND=noninteractive

RUN pip3 install --no-cache-dir tensorflow

# Setup work directory for backward-compatibility
# RUN chown $NB_UID:$NB_GID $HOME && chmod g+rwX $HOME

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

