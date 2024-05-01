FROM alpine:3.9

# Alpine 3.9 tiene MongoDB 4.0.5-r0 en el repositorio community
# https://pkgs.alpinelinux.org/packages?name=mongodb&branch=v3.9
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/main' >> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/community' >> /etc/apk/repositories \
    && apk update \
    && apk add mongodb

COPY ./mongo/start /tmp/

CMD ["/bin/sleep","1d"]