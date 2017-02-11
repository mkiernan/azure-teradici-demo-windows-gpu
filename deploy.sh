#!/bin/bash
#
# Script to deploy using Azure CLI 2.0
#
az group create --location "West Europe"  --name "vizgrp"
# deploy from local template files
#az group deployment create -g vizgrp --template-file azuredeploy.json --parameters @azuredeploy.parameters.json
# deploy from github template [you can also add --parameters followed by a .json string as well as the parameters file method above]
az group deployment create -g vizgrp --template-uri https://raw.githubusercontent.com/mkiernan/azure-teradici-demo-windows-gpu/master/azuredeploy.json 