#!/usr/bin/make
#
all: run
VERSION=`cat version.txt`
#BUILD_NUMBER := debug1
UID := $(shell id -u)
PROJECTID := $(shell basename "${PWD}")
IMAGE_NAME="docker-staging.imio.be/iasmartweb/ideabox:latest"

buildout.cfg:
	ln -fs dev.cfg buildout.cfg
	#ln -fs prod.cfg buildout.cfg

bin/buildout: buildout.cfg
	python bootstrap.py

.PHONY: buildout
buildout:
	make build

.PHONY: robot-server
robot-server:
	bin/robot-server -v cpskin.policy.testing.CPSKIN_POLICY_ROBOT_TESTING

.PHONY: run
run: build
	make up

.PHONY: cleanall
cleanall:
	rm -fr develop-eggs downloads eggs parts .installed.cfg lib include bin .mr.developer.cfg .env nginx.conf

docker-image:
	docker build --pull -t iasmartweb/ideabox:latest .

buildout-prod:
	# used in docker build
	pip install --user -I -r requirements.txt
	~/.local/bin/buildout -t 22 -c prod.cfg

.env:
	echo uid=${UID} > .env

build: .env
	docker-compose pull
	docker-compose run zeo /usr/bin/python bootstrap.py -c docker-dev.cfg
	docker-compose run zeo bin/buildout -c docker-dev.cfg

up: .env
	docker-compose up

pip:
	if [ -f /usr/bin/virtualenv-2.7 ] ; then virtualenv-2.7 .;else virtualenv -p python2.7 .;fi

bin/buildout: pip
	./bin/pip install -r requirements.txt

eggs:  ## Copy eggs from docker image to speed up docker build
	-docker run --entrypoint='' $(IMAGE_NAME) tar -c -C /home/imio/.buildout eggs | tar x
	mkdir -p eggs
