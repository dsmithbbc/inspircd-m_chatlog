####
# This builds the m_chatlog.so module against inspircd v3.14.0 in a Docker image
###

FROM alpine:3.17 as build

RUN apk update && apk add \
    build-base \
    git \
    perl

RUN git clone -v https://github.com/inspircd/inspircd.git && \
    cd /inspircd && \
    git checkout tags/v3.14.0 -b v3.14.0

COPY m_chatlog.cpp /inspircd/src/modules/extra

RUN cd /inspircd && \
    ./configure --enable-extras=m_chatlog.cpp && \
    ./configure --disable-interactive --disable-ownership

RUN cd /inspircd && \
    make -j2 INSPIRCD_TARGET=m_chatlog

RUN cd / && cp -l /inspircd/build/G*/modules/m_chatlog.so . && ls -lL m_chatlog.so
