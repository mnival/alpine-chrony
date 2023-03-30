FROM alpine:3.17.3

# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.authors="Michael Nival" \
	org.opencontainers.image.url="https://github.com/mnival/alpine-chrony/" \
	org.opencontainers.image.documentation="https://github.com/mnival/alpine-chrony/" \
	org.opencontainers.image.source="https://github.com/mnival/alpine-chrony/" \
	org.opencontainers.image.description="Alpine image with chrony"

RUN set -ex; \
  addgroup -g 110 -S chrony; \
  adduser --system --gecos "Chrony daemon" --ingroup chrony --home /var/log/chrony/ chrony --uid 110

RUN set -ex; \
  apk upgrade --no-cache --update; \
  apk add --no-cache chrony

COPY start-chrony.sh /usr/local/bin/

RUN set -ex; \
  chmod u+x /usr/local/bin/start-chrony.sh

ENV chronyconf_pool="pool.ntp.org iburst" \
	chronyconf_initstepslew="10 pool.ntp.org" \
	chronyconf_driftfile="/var/lib/chrony/chrony.drift" \
	chronyconf_rtcsync= \
	chronyconf_cmdport="0"

HEALTHCHECK CMD chronyc tracking || exit 1

EXPOSE 123/udp

ENTRYPOINT ["start-chrony.sh"]
