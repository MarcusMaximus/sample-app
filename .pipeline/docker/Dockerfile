# ARG values be overwritten at build time with e.g. "docker build --build-arg NEW_BASE --build-arg NEW_BASE_VERSION=x.y"
ARG BASE=python
ARG BASE_VERSION=3

FROM ${BASE}:${BASE_VERSION}
WORKDIR /opt

# To use with labels Arg needs to be redeclared after FROM https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG BASE
ARG BASE_VERSION

LABEL buildBase=$BASE
LABEL buildBaseVersion=$BASE_VERSION
# Identify the maintainer of an image
LABEL maintainer="lynch.l9@gmail.com"

COPY ./scripts /opt
ADD product.tar.gz /opt

RUN chmod 755 /opt/*.sh
RUN /opt/setup-base.sh

EXPOSE 5000

ENTRYPOINT ["/opt/entrypoint.sh"]