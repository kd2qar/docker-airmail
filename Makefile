################


TAG=kd2qar/airmail
NAME=airmail


all: build


build:
	docker buildx build --rm --tag ${TAG} .


run: remove
	docker run -it --hostname airmail-host --publish=3389:3389/tcp --name ${NAME} ${TAG} /bin/bash
	# docker run -it --publish=3389:3389/tcp  airmail /bin/bash

stop:
	docker stop ${NAME}; true;

remove: stop
	docker rm ${NAME}; true;
