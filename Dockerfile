# FROM python:3.8
FROM amazonlinux:2

RUN python --version

RUN yum update -y
RUN yum install -y gcc openssl-devel bzip2-devel libffi-devel wget tar gzip make sqlite-devel git

WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz && tar xzf Python-3.8.5.tgz && cd Python-3.8.5 \
    && ./configure --enable-optimizations --enable-loadable-sqlite-extensions && make install

RUN alternatives --install /usr/bin/python python /usr/local/bin/python3.8 2
RUN alternatives --install /usr/bin/python python /usr/bin/python2.7 1

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

RUN python --version

COPY Makefile /app/
COPY analyze /app/analyze
COPY crawler /app/crawler
COPY runner /app/runner
COPY algorithms /app/algorithms
COPY configs /app/configs
COPY setup.py /app/
COPY setup.cfg /app/

WORKDIR /app
RUN make build

WORKDIR /app/runner

ENTRYPOINT [ "celery", "worker", "--app", "settings.celery_app", "-l", "info", "-P", "solo", "--without-gossip"]
