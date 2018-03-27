#!/usr/bin/make
#
all: run
VERSION=`cat version.txt`
#BUILD_NUMBER := debug1
UID := $(shell id -u)
PROJECTID := $(shell basename "${PWD}")

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
	docker build --pull -t docker-staging.imio.be/iasmartweb/ideabox:latest .

buildout-prod: bin/buildout
    # used in docker build
	bin/buildout -t 22 -c prod.cfg

.env:
	echo uid=${UID} > .env

build: .env
	docker-compose pull
	docker-compose run zeo /usr/bin/python bootstrap.py -c docker-dev.cfg
	docker-compose run zeo bin/buildout -c docker-dev.cfg

up: .env
	docker-compose up
