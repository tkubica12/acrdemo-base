# Create ACR
az group create -n acr -l westeurope
az acr create -n tomasacrdemo -g acr --sku Standard

# Manual build and push
docker build --tag tomasacrdemo.azurecr.io/base:flash .
az acr login -n tomasacrdemo
docker push tomasacrdemo.azurecr.io/base:flask

# Build as a service
az acr build --registry tomasacrdemo --image base:flask .

# App image
## Follow instructions in https://github.com/tkubica12/acrdemo-app.git

