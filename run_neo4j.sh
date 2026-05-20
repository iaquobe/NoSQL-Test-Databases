#!/bin/bash

#TODO: gegebenenfalls nach oben anpassen falls ihr connection error bekommt
wait_time=10

if ! $(docker ps | grep -q 'neo4j') ; 
then 
	echo "container not found init database"
	docker run \
		-d \
		--name neo4j \
		--env NEO4J_AUTH=neo4j/mypassword \
		--volume ./neo4j/data:/data-\
		neo4j

	sleep ${wait_time}s
	docker exec -i neo4j cypher-shell -u neo4j -p mypassword <./neo4j/graph.txt
fi

docker exec -it neo4j cypher-shell -u neo4j -p mypassword
