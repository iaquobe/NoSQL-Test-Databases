# Usage 

This repository provides some testing environment for NoSQL database systems, 
so that you can test how the query languages work. 

Just use the scripts with `./run_<database>.sh` in this directory. 
The scripts will start a docker container with the database system, 
then it will create some test data,
and then it will enter a shell where you can write some queries.
When you are done you can kill the containers with 
`docker kill <database>; docker rm <database>`


## Neo4J

You can Create the container and enter teh Cypher-Shell with `./run_neo4j.sh`
There you can run cypher queries, some example queries are described in the next section. 
When you are finished you can exit with `:exit`
The database is created with the following nodes and connections: 

```
CREATE 
(n1:Node {name:1}), (n2:Node {name:2}), (n3:Node {name:3}), (n4:Node {name:4}),
(n5:Node {name:5}), (n6:Node {name:6}), (n7:Node {name:7}), (n8:Node {name:8}),

(n1)-[:LINK]->(n2), (n2)-[:LINK]->(n3), (n3)-[:LINK]->(n1), (n3)-[:LINK]->(n4),
(n3)-[:LINK]->(n5), (n4)-[:LINK]->(n5), (n4)-[:LINK]->(n7), (n5)-[:LINK]->(n6),
(n6)-[:LINK]->(n4), (n6)-[:LINK]->(n7), (n6)-[:LINK]->(n8), (n7)-[:LINK]->(n8);
```

#### Queries 

Returns nodes a, b, c matching this connection pattern:
```
MATCH (a)-->(b)-->(c)<--(a)
RETURN a.name, b.name, c.name;
```

Return nodes and lengths for paths between nodes 1 and 7 with max length of 4:
```
MATCH p=(a)-[*1..4]-(b)
WHERE a.name = 1 AND b.name = 7
RETURN nodes(p), length(p);
```


Return shortest Path between 1 and 7: 
```
MATCH p=shortestPath((a)-[*..4]-(b))
WHERE a.name = 1 AND b.name = 7
RETURN nodes(p);
```

## MongoDB

You can Create the container and enter mongosh with `./run_mongo.sh`
There you can execute queries, some example queries are described in the next section. 
When you are finished you can exit with `exit()` or `quit()`.
The Database contains json files with the following format: 

```json
{
    "city":"Tokyo",
	"population":13960000,
	"continent":"Asia",
	"country":"Japan",
	"known_for":["technology", "finance", "anime culture"],
	"coordinates":{"lat":35.6762, "long":139.6503},
    "timezone":"Asia/Tokyo"
}
```

> Note: the city data was generated with ChatGPT, and I haven't checked the data. 
Hallucination levels may range from 1 beer to 5 tabs of ACID. 
But ACID is good for databases, so I hope it's OK. 


#### Queries 

| description | query | 
|--|--| 
| return all cities | `db.cities.find()` | 
| Find in Europe (only print city name) | `db.cities.find({ continent : 'Europe' }, { _id:0, city : 1}) `| 
| Return cities known for history or government | `db.cities.find({known_for: {$in : ['history', 'government']}}, { _id : 0})` | 
