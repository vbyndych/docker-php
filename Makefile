IMAGE_NAME=vbyndych/oro-docker-php
TAG=7.4

ifeq ($(TAG), 7.4)
	FILE=Dockerfile_7.4
else
	FILE=Dockerfile
endif


build:
	/usr/bin/docker build --tag $(IMAGE_NAME):$(TAG) --file $(FILE) --build-arg PHP_VERSION=$(TAG) .
	
push:
	/usr/bin/docker push $(IMAGE_NAME):$(TAG)
