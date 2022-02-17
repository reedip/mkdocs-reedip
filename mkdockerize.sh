#!/bin/bash

if [ $# -ne 2 ]
then
    echo "ERROR, you need to pass 2 arguments: Action (serve/produce) and Dir location"
    exit 1
fi
if [ "$1" = "serve" ]
then
    # Remove old doc output, and recreate it. Then untar the tar file, and serve it on 8000
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



