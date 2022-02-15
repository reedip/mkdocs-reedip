# mkdocs-reedip
Mkdocs on Docker

## Building the file

We can build the image using the below command to create the base image
` docker build . -f mkdocs.Dockerfile -t mkdocs_test:0.0.0.4`

## Creating the Website 
We can build the website using the below command
`docker run -v $BASE_DIR_WHERE_LOCAL_DIR_LIES:/opt $IMAGE_ID produce $LOCAL_DIRECTORY_WITH_BASE_WEBSITE_FILE`

## Running the website
`docker run -p 8000:$HOST_PORT -d -v $BASE_DIR_WHERE_TAR_FILE_LIES:/opt $IMAGE_ID serve mkdocs_output_$EPOCH.tar.gz`
