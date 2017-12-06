IMAGE_NAME=vbyndych/oro-docker-php
TAG=latest

ifeq ($(TAG), 7.0)
	DIR=7.0/
else ifeq ($(TAG), 5.6)
	DIR=5.6/
else
	DIR=./
endif

build:
	/usr/bin/docker build -t $(IMAGE_NAME):$(TAG) $(DIR)
	
push:
	/usr/bin/docker push $(IMAGE_NAME):$(TAG)
