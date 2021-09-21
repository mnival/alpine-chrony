Docker debian-chrony
============

Configuration Docker with alpine and package : chrony

Quick Start
===========
    docker run -d -p 123:123/udp --cap-add=SYS_TIME --name chrony mnival/alpine-chrony

Interfaces
===========

Ports
-------

* 123(udp) -- NTP

Volumes
-------

N/A

Maintainer
==========

Please submit all issues/suggestions/bugs via
https://github.com/mnival/alpine-chrony
