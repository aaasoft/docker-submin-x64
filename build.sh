#!/bin/sh

VERSION=`cat VERSION`

docker build \
	-t aaasoft/submin-x64:${VERSION} \
	.
