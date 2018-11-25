## Introduction
This repository holds various ML examples related to the articles I write about in the ML blog. This repository has been dockerised so that the code can be run by following the procedure outlined below.

## Building docker image
`docker build -t ml-thushv89 --build-arg NB_USER=$(whoami) --build-arg NB_UID=$(id -u) --build-arg NB_GID=$(id -g) uti
ls.docker/`

## Running the Docker container
`docker run -it -d --rm --init --user=$(whoami) -p <host_port>:8888 -v $(pwd):/home/$(whoami) ml-thushv89:latest jupyter note
book`

## Accessing via web browser
1. `<docker-machine ip>:<host_port>`
2. Enter the notebook token by:
	* Enter to the container via `docker exec -it <contaienr_id> /bin/bash`
	* Run `jupyter notebook list` to get the token