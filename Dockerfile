FROM docker-staging.imio.be/iasmartweb/cache:latest
RUN mkdir /home/imio/imio-website
COPY *.cfg Makefile *.py *.txt /home/imio/imio-website/
RUN chown imio:imio -R /home/imio/imio-website/ \
  && cd /home/imio/imio-website \
  && /usr/bin/python bootstrap.py -c prod.cfg \
  && make buildout-prod \
  && chown -R imio:imio /home/imio/ \
  && runDeps="poppler-utils wv rsync lynx netcat libxml2 libxslt1.1 libjpeg62 libtiff5 libopenjp2-7" \
  && apt-get update \
  && apt-get install -y --no-install-recommends $runDeps \
  && apt-get remove -y gcc python-dev \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean
WORKDIR /home/imio/imio-website
USER imio
ENV ZEO_HOST db
ENV ZEO_PORT 8100
ENV HOSTNAME_HOST local
ENV PROJECT_ID ideabox
