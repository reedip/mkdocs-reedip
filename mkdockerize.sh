#! /bin/bash

echo "Please pass the local directory which you want to use to create the mkdocs website"
read $path
parent="$(basename "$(dirname "$filepath")")"
cd $path

## Running the Produce command
IMAGE_ID=`docker image|grep mkdoc|awk '{print $3}'`
docker run -v $PWD:/opt $IMAGE_ID produce $2

## Running the serve command
find . -name 'mkdocs_output_*.tar.gz'|xargs docker run -p 8000:$HOST_PORT -d -v $PWD:/opt $IMAGE_ID serve 




