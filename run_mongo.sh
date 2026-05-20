#!/bin/bash

#TODO: gegebenenfalls nach oben anpassen falls ihr connection error bekommt
wait_time=10

if ! $(docker ps | grep -q 'mongo') ; 
then 
	echo "container not found init database"
	docker run \
		-d \
		--name mongo \
		-v ./mongo/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d:Z \
		mongo:7.0
	sleep ${wait_time}s
fi

docker exec -it mongo mongosh
