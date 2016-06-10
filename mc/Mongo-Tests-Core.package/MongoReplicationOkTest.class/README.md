Tests for Mongo Replica Set support with replica set available. 

Follow these steps in command-line  to  set up the external mongodb environment:

```
# set up some variables
baseRepositoryPath=/home/<username>/mongo/testreplication/
replicaSetName=foo

# only first time: create db dirs
for i in `seq 1 3`;
do
	mkdir $baseRepositoryPath$replicaSetName$i
done

# serve repos
for i in `seq 1 3`;
do
	echo starting mongod at port 2703$i at $baseRepositoryPath$replicaSetName$i
	mongod --port 2703$i --dbpath $baseRepositoryPath$replicaSetName$i --replSet $replicaSetName --smallfiles --oplogSize 128 &>/dev/null &
done

# wait them a bit
sleep 5s

# configure replication set
mongo --port 27031 --eval 'rs.initiate({ "_id" : '\"${replicaSetName}\"', "members" : [ { "_id" : 1, "host" : "localhost:27031", } ], })'
# add secondaries
mongo --port 27031 --eval 'rs.add("localhost:27032")'
mongo --port 27031 --eval 'rs.add("localhost:27033")'
```