#!/bin/bash

set -ex
source $(dirname $0)/rs-checkEnvirnomentVariables.sh

# create each db directory if it doesn't exist
for i in `seq 1 3`;
do
	mkdir -p $baseRepositoryPath$replicaSetName$i
done
