#
# This Docker image encapsulates the Rekall Memory Forensic Framework,
# which is available at http://www.rekall-forensic.com.
#
# To run this image after installing Docker, use a command like this:
#
# sudo docker run --rm -it -v ~/files:/home/nonroot/files remnux/rekall bash
#
# then run "rekall" in the container with the desired parameters.
#
# Before running the command above, create the "files" directory on your host and
# make it world-accessible (e.g., "chmod a+xwr ~/files").
#
# To use Rekall's web console, invoke the container with the -p parameter to give
# your host access to the container's TCP port 8000 like this:
#
# sudo docker run --rm -it -p 8000:8000 -v ~/files:/home/nonroot/files remnux/rekall
#
# Then connect to http://localhost:8000 using a web browser from your host.
#

FROM python:2.7-alpine3.8
MAINTAINER @jbeley

ENV VOL_VERSION 2.6.1
ENV PIP_NO_CACHE_DIR off
ENV PIP_DISABLE_PIP_VERSION_CHECK on
USER root

RUN apk add --no-cache ca-certificates zlib py-pillow py-crypto py-lxml py-setuptools libxslt-dev openssl less
RUN apk add --no-cache -t .build-deps \
  openssl-dev \
  python-dev \
  build-base \
  zlib-dev \
  libc-dev \
  jpeg-dev \
  py-pip \
  mercurial \
  autoconf \
  automake \
  libtool \
  libmagic \
  git \
  flex \
  && pip install --upgrade pip wheel \
  && pip install \
  simplejson \
  python-Levenshtein \
  M2Crypto \
  construct==2.5.5-reupload \
  ctypeslib2 \
  openpyxl \
  haystack==0.36 \
  distorm3 \
  colorama \
  ipython \
  pycoin \
  pytz \
  pysocks \
  requests \
  pycrypto \
  && cd /tmp \
  && hg clone https://bitbucket.org/jmichel/dpapick \
  && cd /tmp/dpapick \
  && python setup.py install \
  && cd /tmp \
  && git clone --recursive https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
  && mkdir /plugins \
  && cd /plugins \
  && git clone https://github.com/volatilityfoundation/community.git \
  && cd community \
  && rm -rf /plugins/community/AlexanderTarasenko \
  && rm -rf /plugins/community/MarcinUlikowski \
  && mv /tmp/volatility/contrib/plugins contrib \
  && cd /tmp \
  && git clone --recursive --branch v0.2.2 https://github.com/mandiant/ioc_writer.git \
  && cd ioc_writer \
  && python setup.py install

  # goes after cd community
  #&& git reset --hard 29b07e7223f55e3256e3faee7b712030676ecdec \
RUN cd /tmp/ && \
       git clone --recursive https://github.com/VirusTotal/yara.git && \
       cd /tmp/yara && \
       ./bootstrap.sh && \
        sync && \
       ./configure --prefix=/usr  && \
        make clean all install && \
        pip install --upgrade yara-python

RUN cd /plugins/community/YingLi \
  && touch __init__.py \
  && cd /plugins/community/StanislasLejay/linux \
  && touch __init__.py \
  && cd /plugins/community/DatQuoc \
  && touch __init__.py \
  && cd /plugins/community/DimaPshoul \
  && sed -i 's/import volatility.plugins.malware.callstacks as/import/' malthfind.py

RUN mkdir /plugins/cobalt && \
        wget -O /plugins/cobalt/cobaltstrikescan.py  https://raw.githubusercontent.com/JPCERTCC/aa-tools/master/cobaltstrikescan.py

RUN git clone https://github.com/JPCERTCC/MalConfScan /plugins/malconfscan/ && \
        pip install -r /plugins/malconfscan/requirements.txt

RUN  rm -rf /tmp/* \
  && apk del --purge .build-deps


VOLUME ["/data"]
VOLUME ["/plugins"]

