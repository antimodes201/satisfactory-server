#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm satisfactory
docker run -it -p 7777:7777/udp -p 15777:15777/udp -p 15000:15000/udp -v /app/docker/temp-vol:/satisfactory \
-e BRANCH="experimental" \
--name satisfactory \
antimodes201/satisfactory-server:latest
