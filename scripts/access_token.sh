#!/bin/bash

echo "Enter password"
read -s PASSWORD

curl -X POST -d "password=$PASSWORD" 'https://api.brandwatch.com/oauth/token?username=alastair@brandwatch.com&grant_type=password&client_id=brandwatch-application-client'
