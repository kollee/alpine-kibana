FROM alpine:latest

# install plugin dependencies
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ su-exec tini nodejs

ENV KIBANA_MAJOR 4.5
ENV KIBANA_VERSION 4.5.1

COPY install_kibana.sh /

RUN /install_kibana.sh

ENV PATH /opt/kibana-${KIBANA_VERSION}-linux-x64/bin:$PATH

COPY docker-entrypoint.sh /

EXPOSE 5601
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
