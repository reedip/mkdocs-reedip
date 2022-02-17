# mkdocs-reedip
MkDocs on Docker

This repo can be used to create and serve a website using MkDocs, using Docker.
MkDocs is a fast & simple static site generator intended in building project documentation. 
Documentation source files are written in Markdown, and configured with a single YAML configuration file.
More information on https://www.mkdocs.org/


## Building the file

We can build the docker image using the below command:

`docker build . -f mkdocs.Dockerfile -t mkdocs_test:$BUILD_NUMBER`

This creates the base image which can be used to deploy the website. 

Parameter used here: 
- BUILD_NUMBER: The Build Number used to create the tag for the mkdocs_test image

## Creating the Website 

We can build the website using the below command

`docker run -v $BASE_DIR_WHERE_LOCAL_DIR_LIES:/opt mkdocs_test:$BUILD_NUMBER produce $LOCAL_DIRECTORY_WITH_BASE_WEBSITE_FILE`

Internally this command will call the shell script startUp.sh which will build produce the website.

The parameters for this website include:
- BASE_DIR_WHERE_LOCAL_DIR_LIES: This is the directory which would be mounted onto /opt of the docker image.
  This is the parent diectory where the LOCAL_DIRECTORY_WITH_BASE_WEBSITE_FILE is located. 

- LOCAL_DIRECTORY_WITH_BASE_WEBSITE_FILE: This is the directory which is expected to be build by mkdocs. This should have the mkdocs.yml
  as required by mkdocs script at its root.

- BUILD_NUMBER: The Build Number which was used to create the tag for the mkdocs_test image

## Running the website
You can build the website using the below command

`docker run -p 8000:$HOST_PORT -d -v $BASE_DIR_WHERE_TAR_FILE_LIES:/opt mkdocs_test:$BUILD_NUMBER serve mkdocs_output_$EPOCH.tar.gz`

- BASE_DIR_WHERE_LOCAL_DIR_LIES: This is the directory which would be mounted onto /opt of the docker image.
  This is the parent diectory where the tar file mkdocs_output_$EPOCH.tar.gz resides 

- BUILD_NUMBER: The Build Number which was used to create the tag for the mkdocs_test image

- EPOCH: This is the naming convention used for mkdocs_output's tar file

## Using the wrapper.sh:
The wrapper.sh takes in 2 input parameters which are 
a) Path to the Valid MkDocs Project
b) Host Port where the code will be deployed.

Just running the warpper.sh would be enough to deploy the whole code in one go

### Appendix:

#### Scope of Improvement:

This code can be improved much further, including:
- Path independence: We should not be tied up with the BASE_DIR_WHERE_LOCAL_DIR_LIES. We can load it directly by making the Entrypoint script smarter

- Managing the Tar file: We build the tar file in the same location of BASE_DIR_WHERE_TAR_FILE_LIES, but we do not remove existing tar files, that can be improved.
  The naming convention is based on the EPOCH time so that multiple generations can still be easily managed.

- Using inbuilt libraries in JenkinsFile: The Jenkinsfile created here uses a lot of shell scripting but can use the docker library directly to reduce some code. 
  The reason for using the shell script here was to create a deliverable as soon as possible, with all working functionality.

#### Points to Note:
-  The requirement was not completely clear from my side as to what the STDOUT  for produce would be, would it be STDOUT the tar file complete, or just the name
    I did the best thing I can to make it simple, but if there was a client interaction for use-case confirmation, it would have been great
-  The requirement mentioned in the document is that if docker run -p 8000:8000 is used, then mkdocs's 8000 port is forwarded to the host's 8000. I considered this in the way
    that the mkdocs will internally continue to use 8000 port, but its mapping can be done to any host port. So docker run -p 8000:8001 will map 8001 of Host to 8000 of docker container
