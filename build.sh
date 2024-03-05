#!/bin/sh
git submodule update --init --recursive
docker build -t www-jasonsblog:latest . --progress plain
