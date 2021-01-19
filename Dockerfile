# FROM python:3.8
FROM amazonlinux:2

RUN python --version


WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz && tar xzf Python-3.8.5.tgz && cd Python-3.8.5 \
    && ./configure --enable-optimizations --enable-loadable-sqlite-extensions && make install

RUN alternatives --install /usr/bin/python python /usr/local/bin/python3.8 2
RUN alternatives --install /usr/bin/python python /usr/bin/python2.7 1

RUN testing

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

RUN python --version

COPY Makefile /app/
COPY analyze /app/analyze
COPY crawler /app/crawler
COPY configs /app/configs
COPY setup.py /app/

WORKDIR /app
RUN make build

RUN gotcha
WORKDIR /app/runner

