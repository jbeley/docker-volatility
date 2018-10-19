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

FROM python:2.7
MAINTAINER @jbeley

USER root

RUN apt-get update && apt-get install -y \
        unzip
#    git \
#    gcc \
#    python-dev \
#    python-pip \
#    curl \
#    libtool \
#    autoconf \
#    python-socks \
#    python-numpy \
#    python-scipy \
#    bison \
#    byacc \
#    python-m2crypto \
#    python-levenshtein \
#    libffi-dev \
#    libssl-dev \
#    libimage-exiftool-perl \
#    libfuzzy-dev \
#    vim \
#    supervisor
#
#
#
#RUN pip install -q distorm3 \
#    gevent-websocket \
#    flask-sockets \
#    codegen \
#    acora \
#    pyelftools \
#    pycrypto
#
#RUN curl -SL "https://github.com/plusvic/yara/archive/v3.4.0.tar.gz" | tar -xzC . && \
# cd yara-3.4.0 && \
#  ./bootstrap.sh && \
#  ./configure && \
#  make && \
#  make install && \
#  cd yara-python/ && \
#  python setup.py build && \
#  python setup.py install && \
#  cd ../.. && \
#  rm -rf yara-3.4.0 && \
#  ldconfig
#
#RUN apt-get -y -q install libncurses-dev
#
RUN   pip install rekall

RUN wget -O /tmp/master.zip https://github.com/google/rekall-profiles/archive/master.zip \
    && unzip -d /tmp/ /tmp/master.zip \
    && mv /tmp/rekall-profiles-master/v1.0 /rekall-profiles


RUN   apt-get remove -y --purge git automake libtool byacc && \
  apt-get autoremove -y --purge && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* /root/.cache /tmp/master.zip

#RUN groupadd -r nonroot && \
#  useradd -r -g nonroot -d /home/nonroot -s /sbin/nologin -c "Nonroot User" nonroot && \
#  mkdir /home/nonroot && \
#  chown -R nonroot:nonroot /home/nonroot
#
#USER nonroot
#ENV HOME /home/nonroot
#ENV USER nonroot
#USER root
#WORKDIR /home/nonroot
ADD rekallrc /root/.rekallrc
#RUN chown nonroot /home/nonroot/.rekallrc
