#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/rs-createDbDirectories.sh
$DIR/rs-serve.sh
$DIR/rs-initiateRS.sh
