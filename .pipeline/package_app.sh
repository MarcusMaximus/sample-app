#!/usr/bin/env bash
set -e

logWithBanner() {
	echo ""
	echo "##############################################"
	echo ""
	echo "$(date +'%Y%m%d-%H%M'):  $1"
	echo ""
	echo "##############################################"
	echo ""
}

logWithBanner "running $(basename "$0") on $(hostname)"
logWithBanner "running in pwd: $(pwd)"
logWithBanner "Contents of $(pwd): $(ls -la)"

PRODUCT_PATH=./product

tar -cvzf product.tar.gz "${PRODUCT_PATH}" --exclude .pipeline --exclude .git 

logWithBanner "Creating docker build folder from ${PRODUCT_PATH}/.pipeline/docker"
cp -vR "${PRODUCT_PATH}/.pipeline/docker" .

logWithBanner "Prepare docker folder for image creation"
mv product.tar.gz ./docker