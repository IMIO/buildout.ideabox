FROM imiobe/base:py3-ubuntu-20.04 as builder
ENV PIP=9.0.3 \
  ZC_BUILDOUT=2.13.2 \
  SETUPTOOLS=41.2.0 \
  WHEEL=0.31.1 \
  PLONE_MAJOR=5.2 \
  PLONE_VERSION=5.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  git \
  libbz2-dev \
  libc6-dev \
  libffi-dev \
  libjpeg62-dev \
  libopenjp2-7-dev \
  libmemcached-dev \
  libpcre3-dev \
  libpq-dev \
  libreadline-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  python3-dev \
  python3-pip \
  wget \
  zlib1g-dev \
  && pip3 install --no-cache-dir pip==$PIP setuptools==$SETUPTOOLS zc.buildout==$ZC_BUILDOUT py-spy

WORKDIR /plone
RUN chown imio:imio -R /plone && mkdir /data && chown imio:imio -R /data

#COPY --chown=imio eggs /plone/eggs/
COPY --chown=imio *.cfg /plone/
COPY --chown=imio scripts /plone/scripts
RUN su -c "buildout -c prod.cfg -t 30 -N" -s /bin/sh imio


FROM imiobe/base:py3-ubuntu-20.04

ENV PIP=9.0.3 \
  ZC_BUILDOUT=2.13.2 \
  SETUPTOOLS=41.2.0 \
  WHEEL=0.31.1 \
  PLONE_VERSION=5.2.1 \
  TZ=Europe/Brussel \
  ZEO_HOST=zeo \
  ZEO_PORT=8100 \
  HOSTNAME_HOST=local \
  PROJECT_ID=ideabox \
  PLONE_EXTENSION_IDS=plone.app.caching:default,plonetheme.barceloneta:default,ideabox.policy:default \
  DEFAULT_LANGUAGE=fr

RUN mkdir -p /data/blobstorage && chown imio:imio -R /data && mkdir /plone && chown imio:imio -R /plone
VOLUME /data/blobstorage
VOLUME /data/filestorage
WORKDIR /plone

RUN apt-get update && apt-get install -y --no-install-recommends \
  libjpeg62 \
  libmemcached11 \
  libopenjp2-7 \
  libpq5 \
  libtiff5 \
  libxml2 \
  libxslt1.1 \
  lynx \
  netcat \
  poppler-utils \
  python3-distutils \
  rsync \
  wget \
  wv \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_amd64.deb > /tmp/dumb-init.deb && dpkg -i /tmp/dumb-init.deb && rm /tmp/dumb-init.deb

LABEL plone=$PLONE_VERSION \
  os="ubuntu" \
  os.version="3.10" \
  name="Plone 5.2.1" \
  description="Plone image for iA.Ideabox" \
  maintainer="Imio"

COPY --from=builder /usr/local/bin/py-spy /usr/local/bin/py-spy
COPY --chown=imio --from=builder /plone .
COPY --from=builder /usr/local/lib/python3.8/dist-packages /usr/local/lib/python3.8/dist-packages
COPY --chown=imio docker-initialize.py docker-entrypoint.sh /

USER imio
EXPOSE 8080
HEALTHCHECK --interval=1m --timeout=5s --start-period=30s \
  CMD nc -z -w5 127.0.0.1 8080 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["console"]

