#!/bin/bash

rm -r ./bin ./lib
R=${RANDOM}
docker build ./build --no-cache -t bytepen/guacenc:build
docker run -d --name guacenc-build-${R} bytepen/guacenc:build
docker cp guacenc-build-${R}:/usr/local/bin .
docker cp guacenc-build-${R}:/usr/local/lib .
docker container rm guacenc-build-${R}
docker image rm bytepen/guacenc:build
docker build . --no-cache -t bytepen/guacenc:latest
rm -r ./bin ./lib
docker push bytepen/guacenc:latest
