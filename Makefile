#!/usr/bin/make

IMAGE_NAME="docker-staging.imio.be/ideabox/mutual:latest"

build: dev

bin/pip:
	python3 -m venv .

run: bin/instance
	bin/instance fg

docker-image:
	docker build --pull -t ideabox/mutual:latest .

test-image:
	echo test

cleanall:
	rm -fr develop-eggs downloads eggs parts .installed.cfg lib include bin .mr.developer.cfg local lib64
	docker-compose down

bash:
	docker-compose run --rm -p 8080:8080 -u imio instance bash

var/filestorage:
	mkdir -p var/filestorage

var/blobstorage:
	mkdir -p var/blobstorage

buildout.cfg:
	ln -fs dev.cfg buildout.cfg

dev: bin/pip buildout.cfg
	./bin/pip install -r requirements.txt
	./bin/buildout -t 30

bin/buildout: dev

eggs:  ## Copy eggs from docker image to speed up docker build
	-docker run --entrypoint='' $(IMAGE_NAME) tar -c -C /plone eggs | tar x
	mkdir -p eggs

data:
	mkdir data

fix-data-permissions: data
	sudo chown $(USER):$(USER) data
	docker-compose run --entrypoint="" --rm -u root zeo chown -R imio:imio /data

docker-build: eggs
	docker-compose build
	make fix-data-permissions

create-plonesite: fix-data-permissions
	docker-compose run instance bin/instance run scripts/create_plonesite.py

bin/intance: bin/buildout

upgrade: bin/instance
	docker-compose run instance bin/instance run scripts/run_portal_upgrades

rsync: var/filestorage var/blobstorage
	rsync -rP imio@pre-prod3.imio.be:/srv/instances/marcheid/filestorage/Data.fs var/filestorage/Data.fs
	rsync -r --info=progress2 imio@pre-prod3.imio.be:/srv/instances/marcheid/blobstorage/ var/blobstorage/
