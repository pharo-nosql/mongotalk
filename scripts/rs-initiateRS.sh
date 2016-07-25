#!/bin/bash

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$DIR/rs-checkEnvirnomentVariables.sh

# wait mongos are ready
for i in `seq 1 3`;
do
	until nc -z localhost 2703$i ; do echo "waiting for mongo 2703$i"; sleep 1; done
done

# set up mongo A
mongo --port 27031 --eval 'rs.initiate({ "_id" : '\"${replicaSetName}\"', "members" : [ { "_id" : 1, "host" : "localhost:27031", } ], })'

# add mongo B and C
mongo --port 27031 --eval 'rs.add("localhost:27032")'
mongo --port 27031 --eval 'rs.add("localhost:27033")'

# reconfigure with descending priorities (5, 3, 0)
mongo --port 27031 --eval 'rs.reconfig({ "_id" : '\"${replicaSetName}\"', "members" : [ { "_id" : 1, "host" : "localhost:27031", "priority" : 5.0, }, { "_id" : 2, "host" : "localhost:27032", "priority" : 3.0, }, { "_id" : 3, "host" : "localhost:27033", "priority" : 0.0, } ], }, {force: true})'

