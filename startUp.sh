#!/bin/bash

if [ $# -lt 1 ]
then
    echo "ERROR, you need to pass more than one arg and it should be serve/produce"
    exit 1
fi
echo $1
if [ "$1" = "serve" ]
then
    rm -rf /tmp/docs_output
    mkdir -p /tmp/docs_output
    tar zxvf /opt/$2  --directory /tmp/docs_output 2>&1 1>/dev/null
    cd /tmp/docs_output/ 
    ls -alrt
    mkdocs serve -a 0.0.0.0:8000 

elif [ "$1" = "produce" ]
then
    cd /opt/$2 2>&1 1>/dev/null
    ts=`date +%s`
    mkdocs build -c -q -s -dmkdocs_output
    tar czvf mkdocs_output_$ts.tar.gz * 2>&1 1>/dev/null
    rm -rf mkdocs_output
    rm -rf /opt/mkdocs_output*.tar.gz
    mv mkdocs_output_$ts.tar.gz /opt
    echo "Output file created successfully, please check the local directory for mkdocs_output_$ts.tar.gz"
    cd -
else
    echo "Wrong arguments passed, please pass produce/serve or mkdocs"
fi



# Points to Note:
# a) The requirement was not completely clear from my side as to what the STDOUT  for produce would be, would it be STDOUT the tar file complete, or just the name
#    I did the best thing I can to make it simple, but if there was a client interaction for use-case confirmation, it would have been great
# b) The requirement mentioned in the document is that if docker run -p 8000:8000 is used, then mkdocs's 8000 port is forwarded to the host's 8000. I considered this in the way
#    that the mkdocs will internally continue to use 8000 port, but its mapping can be done to any host port. So docker run -p 8001:8000 will map 8001 of Host to 8000 of docker container
