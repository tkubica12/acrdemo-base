# Create ACR
az group create -n acr -l westeurope
az acr create -n tomasacrdemo -g acr --sku Standard

# Manual build and push
docker build --tag tomasacrdemo.azurecr.io/base:v1 .
az acr login -n tomasacrdemo
docker push tomasacrdemo.azurecr.io/base:v1

# Build as a service
az acr build --registry tomasacrdemo --image base:v2 .

# Automated build
az acr build-task create \
    --registry tomasacrdemo \
    --name baseautobuild \
    --image base:{{.Build.ID}} \
    --context https://github.com/tkubica12/acrdemo-base.git \
    --branch master \
    --git-access-token $GIT_PAT

az acr build-task run --registry tomasacrdemo --name baseautobuild

az acr build-task logs --registry tomasacrdemo