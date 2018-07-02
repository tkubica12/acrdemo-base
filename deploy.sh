az group create -n acr -l westeurope
az acr create -n tomasacrdemo -g acr --sku Standard

az acr build --registry tomasacrdemo --image base:1.0.1 .