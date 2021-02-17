#!/bin/sh

# Exit on error
set -e 

# ACR Login
az login -t <TENANT_ID>
az acr login --name desouza

# Build the docker images 
docker build . -f Dockerfile.admin -t desouza.azurecr.io/<IMAGE_NAME>

# Push the images to acr
docker push  desouza.azurecr.io/<IMAGE_NAME>:latest