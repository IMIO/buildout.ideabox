FROM docker-staging.imio.be/base:latest as builder
RUN mkdir -p /home/imio/imio-website \
  && mkdir -p /home/imio/.buildout \
  && echo "[buildout]" > /home/imio/.buildout/default.cfg \
  && echo "eggs-directory = /home/imio/.buildout/eggs" >> /home/imio/.buildout/default.cfg \
  && echo "download-cache = /home/imio/.buildout/downloads" >> /home/imio/.buildout/default.cfg \
  && chown imio:imio -R /home/imio/
COPY --chown=imio *.cfg Makefile *.py *.txt /home/imio/imio-website/
COPY --chown=imio eggs /home/imio/.buildout/eggs/
WORKDIR /home/imio/imio-website
RUN buildDeps="python-pip build-essential libpq-dev libreadline-dev wget git gcc libc6-dev libpcre3-dev libssl-dev libxml2-dev libxslt1-dev libbz2-dev libffi-dev libjpeg62-dev libopenjp2-7-dev zlib1g-dev python-dev" \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps
USER imio
RUN make buildout-prod

FROM docker-staging.imio.be/base:latest
WORKDIR /home/imio/imio-website

COPY --chown=imio --from=builder /home/imio/.buildout /home/imio/.buildout
COPY --chown=imio --from=builder /home/imio/imio-website .

RUN runDeps="poppler-utils wv rsync lynx netcat libxml2 libxslt1.1 libjpeg62 libtiff5 libopenjp2-7" \
  && apt-get update \
  && apt-get install -y --no-install-recommends $runDeps \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean
USER imio
ENV ZEO_HOST=db \
  ZEO_PORT=8100 \
  HOSTNAME_HOST=local \
  PROJECT_ID=ideabox
