#!/bin/bash

####
# This builds the m_chatlog.so module against inspircd v3.14.0 in a Docker image
#   and then copies it out to this directory
###


docker build --tag m_chatlog:3.14 .

# Create a temporary container from the image and retieve the module
docker cp -a `docker create --name built_m_chatlog m_chatlog:3.14`:/m_chatlog.so ./

# Delete the temporary container (..but not the image)
docker rm built_m_chatlog

ls -l m_chatlog.so

echo "You may now remove the docker image where the module was built..."
echo "  docker image rm m_chatlog:3.14"

