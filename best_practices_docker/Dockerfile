FROM python:3.5-slim

ARG UID=1000
ARG GID=1000

ENV TINI_VERSION v0.18.0

# Installing linux packages but not caching
RUN apt-get update && \
    apt-get install tini && \
    rm -rf /var/lib/apt/lists/*

# Installing tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Adding non-priviledged uses (adding them to sudo group - optional)
RUN groupadd -g $GID john-group

RUN useradd -N -l -u $UID -g john-group -G sudo john && \
    echo "$UID:pass" | chpasswd && \

# Copying data and code
COPY test-data /data
COPY test-code /app

# Installing python libraries
COPY requirements.txt .
RUN pip3 install -r requirements.txt --no-cache-dir

# Adding a tini entrypoint
ENTRYPOINT ["tini", "--"]

# Setting the workdir (when standing-up the container this will be your default dir)
WORKDIR /app
