FROM alpine

LABEL maintainer="Michael Nival <docker@mn-home.fr>" \
	name="alpine-chrony" \
	description="Alpine with the package chrony" \
	docker.cmd="docker run -d -p 123:123/udp --cap-add=SYS_TIME --name chrony mnival/alpine-chrony"

RUN addgroup -g 110 -S chrony && \
	adduser --system --gecos "Chrony daemon" --ingroup chrony --home /var/log/chrony/ chrony --uid 110

RUN apk upgrade --no-cache --update && \
	apk add --no-cache chrony

ADD start-chrony.sh /usr/local/bin/

ENV chronyconf.pool="pool.ntp.org iburst" \
	chronyconf.initstepslew="10 pool.ntp.org" \
	chronyconf.driftfile="/var/lib/chrony/chrony.drift" \
	chronyconf.rtcsync= \
	chronyconf.cmdport="0"

HEALTHCHECK CMD chronyc tracking || exit 1

EXPOSE 123/udp

ENTRYPOINT ["start-chrony.sh"]
