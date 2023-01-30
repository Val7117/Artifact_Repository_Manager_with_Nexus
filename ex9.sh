#!/bin/bash

# Command uses Nexus Rest Api to fetch the download URL info for the latest NodeJS app artifact. Then saves the artifact details in json file 

curl -u {nexus_username}:{nexus_user_password} -X GET 'http://{nexus_ip_address}/service/rest/v1/components?repository={repository_name}&sort=version' | jq "." > artifact.json

# Grab the download URL from the save artifact details using 'jq' - json processor tool

artifactDownloadURL=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

# Grab the artifact Name and Version from the save artifact details using 'jq' - json processor tool

artifactName=$(jq '.items[].name' artifact.json --raw-output)
artifactVersion=$(jq '.items[].version' artifact.json --raw-output)

# Set a local artifact name with tgz extension

artifactLocalName=$artifactName-$artifactVersion.tgz

# Fetch the artifact with the extracted download URL using 'wget' tool

echo ""
echo "DOWNLOADING an artifact $artifactName-$artifactVersion from $artifactDownloadURL"
echo ""

wget --output-document=$artifactLocalName --http-user="{nexus_username}" --http-password="{nexus_password}" $artifactDownloadURL

echo "DOWNLOADED artifact $artifactName-$artifactVersion from $artifactDownloadURL"

# Untar the artifact

tar -xzvf $artifactLocalName

cd ./package

# Install all the required packages

npm install

# Start nodejs server in the background

nodejs server.js &

echo "The script has been successfully finished!"
exit 0
