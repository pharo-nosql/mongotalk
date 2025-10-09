# Client for Replica Sets

**IMPORTANT:** ReplicaSet support is not included in current V5 driver!

## Introduction

The driver described above is enough in a [MongoDB standalone server](https://docs.mongodb.com/manual/reference/glossary/#term-standalone) configuration where there only one server can execute the operations.
This job can get much more complex when the configuration is a [MongoDB Replica Set](https://docs.mongodb.com/manual/reference/glossary/#term-replica-set).
In this case, a group of servers maintain the same data set providing redundancy and high availability access.

The following figure shows a Replica Set configuration composed by 3 servers (a.k.a. members).
The [Primary server](https://docs.mongodb.com/manual/core/replica-set-primary/) is the only member in the replica set that receives **write** operations.
However, all members of the replica set can accept **read** operations (see [Read Preference](https://docs.mongodb.com/v4.0/core/read-preference/)).

![ReplicaSetFigure](https://docs.mongodb.com/manual/_images/replica-set-read-write-operations-primary.bakedsvg.svg)

The replica set can have at most one primary. If the current primary becomes unavailable, an election determines the new primary.

## MongoClient

To help in this kind of scenarios, the `MongoClient` monitors the Replica Set status to provide the instance of `Mongo` that your application requires to perform an operation.

You can create a client and make it start monitoring as follows:
~~~Smalltalk
client := MongoClient withUrls: urlsOfSomeReplicaSetMembers.
client start.
~~~

After some milliseconds, it should be ready to, for example, receive write operations such as:
~~~Smalltalk
client primaryMongoDo: [ :mongo |
	((mongo
		databaseNamed: 'test')
		getCollection: 'pilots')
		add: { 'name' -> 'Fangio' } asDictionary ].
~~~

Until more documentation is available, you have these options to learn about this client:

* **Example.** Evaluate and browse this code: `MongoClientExample openInWindows`.

* **Test suites.**
Browse the class hierarchy of `MongoClientTest` where you can see diverse tests, setUps, and tearDowns.

* **Visual Monitor.**
You can check [this repository](https://github.com/ObjectProfile/pharo-mongo-client-monitor), which watches the events announced by a `MongoClient` to help to better understand them via visualizations.


