#! /bin/sh

echo "Please pass the local directory which you want to use to create the mkdocs website"
read TEST_PATH
echo "Please pass the port where the website would be served"
read HOST_PORT
PARENT_DIR="$(dirname "$TEST_PATH")"
TEST_DIR="$(basename "$TEST_PATH")"
cd $TEST_PATH

## Running the Produce command
IMAGE_ID=`docker images|grep mkdoc|awk '{print $3}'`
if [ -z $IMAGE_ID ]
then
    echo "Please build the Image first before running mkdockerize"
    exit 1
fi

echo "Producing the website with $IMAGE_ID"
docker run -v $PARENT_DIR:/opt $IMAGE_ID produce $TEST_DIR
if [ $? -eq 0 ]
then
    cd $PARENT_DIR
    echo "Serving the website now"
    ## Running the serve command
    find . -name 'mkdocs_output_*.tar.gz'|xargs docker run -d -p 8000:$HOST_PORT -v $PWD:/opt $IMAGE_ID serve 
fi

if [ $? -eq 0 ]
then
    echo "Website being served, please use docker ps to see the running container and use docker stop/docker rm to stop it"
fi
