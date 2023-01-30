#!/bin/bash

# Command uses Nexus Rest Api to fetch the download URL info for the latest NodeJS app artifact 

curl -u {nexus_username}:{nexus_user_password} -X GET 'http://{ip_address}/service/rest/v1/components?repository=npm-repo&sort=version'

# Download command

wget http://{nexus_username}:{nexus_password}'@{nexus_ip_address}/repository/npm-repo/bootcamp-node-project/-/{filename}

