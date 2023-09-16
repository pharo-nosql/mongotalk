# MongoTalk 
A Pharo driver for [MongoDB](https://www.mongodb.com/).

[![CI](https://github.com/pharo-nosql/mongotalk/actions/workflows/tests.yml/badge.svg)](https://github.com/pharo-nosql/mongotalk/actions/workflows/tests.yml)
[![Coverage Status](https://codecov.io/github/pharo-nosql/mongotalk/coverage.svg?branch=master)](https://codecov.io/gh/pharo-nosql/mongotalk/branch/master)

[![Pharo 10](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)

## Getting Started

We can open a connection to a mongodb server and perform a write operation as follows:
~~~Smalltalk
mongo := Mongo host: 'localhost' port: 27017.
mongo open.
((mongo
	databaseNamed: 'test')
	getCollection: 'pilots')
	add: { 'name' -> 'Fangio' } asDictionary.
~~~

## Install Mongo driver

Evaluate the following script in Pharo:
```smalltalk
Metacello new
	repository: 'github://pharo-nosql/mongotalk/mc';
	baseline: 'MongoTalk';
	load
```

---
## Install MongoClient

```smalltalk
Metacello new
	repository: 'github://pharo-nosql/mongotalk/mc';
	baseline: 'MongoTalk';
	load: #(Client)
```

---
## Older mongo versions (< 5)
Current driver (v5) is incompatible with older mongo versions, if you require to connect to one of those older databases, you will need to first install a legacy driver: 

```smalltalk
Metacello new
	repository: 'github://pharo-nosql/mongotalk/mc';
	baseline: 'MongoTalk';
	load: #('Mongo-DriverLegacy')
```

Then you will need to explicitly declare its use in your mongo client: 
```smalltalk
db := Mongo new
	useLegacyDriver;
	open. 
```

Alternatively, you can also set the default driver to be used in any connection:
```smalltalk
MongoDriver defaultDriver: MongoLegacyDriver.
```
*This is useful if you are using [Voyage](https://github.com/pharo-nosql/voyage), for example.*

---
# The MongoDB specification

The MongoDB core team proposes a [specification](https://github.com/mongodb/specifications) with suggested and required  behavior for drivers (clients).
Although this Pharo driver implements only partially such specification, in next subsections we describe its key elements and link them this Pharo implementation.

## Server Discovery And Monitoring

You can have an introduction to the [Server Discovery And Monitoring Specification](http://emptysqua.re/server-discovery-and-monitoring.html) in a [blog post](https://www.mongodb.com/blog/post/server-discovery-and-monitoring-next-generation-mongodb-drivers) and in [this talk](https://www.mongodb.com/presentations/mongodb-drivers-and-high-availability-deep-dive).

***Discovery.*** The `MongoClient` receives a *seed list* of URLs when instantiated, which is the initial list of server addresses.
After `#start`, the client starts to *ping* the seed addresses to discover replica set data.
This *ping* consists on a [ismaster](https://docs.mongodb.com/v4.0/reference/command/isMaster/) command, which is very light for servers.

***Monitors.*** The spec considers 3 kinds of implementations for monitoring: the single-threaded (Perl), multi-threaded (Python, Java, Ruby, C#), and hybrid (C). The hybrid mixes single and multi.
Our `MongoClient` has a **multi-threaded approach** to monitor servers.
More concretely, it uses [TaskIt](https://github.com/pharo-contributions/taskit) services which relies in `Process` (i.e. [green threads](https://en.wikipedia.org/wiki/Green_threads)).

***States.*** The `MongoClient>>isMonitoringSteadyState` let's you know the internal state of the client, which is one of the following:

* **Crisis state**: It is the initial state: ping each seed address to get the first topology, then move to Steady state. Enqueue incoming commands and ping every 0.5 seconds (not customizable) all known servers until a primary is found. Then, change to Steady state.

* **Steady state**: Ping servers every 10 seconds (by default) to update data, and keep track of latency. When there is a failure, the exception is raised to the application, and it will move to Crisis state.

***Error handling.*** Applications may retry once after a connection failure, and only notify user if this first retry failed too.
The explanation is that first failure moves the client to Crisis State, and the retry will have a long Server Selection and hopefully retry after a new primary is elected.
It is less likely that a second retry will succeed.


## Server Selection

When a client receives a write command, there is only one choice: it must be sent to the primary server.
The same happens when a client receives a read command with *primary* as read preference.
Instead, a read operation with another read preference (such as *primaryPreferred*) might have several possible servers to send the command.
The [Server Selection specification](https://docs.mongodb.com/manual/core/read-preference-mechanics/) proposes the algorithm for server selection that has the goals of being predictable, resilient, and low-latency.
[This blog post](https://www.mongodb.com/blog/post/server-selection-next-generation-mongodb-drivers) describes this algorithm in detail:

> Users will be able to control how long server selection is allowed to take with the [serverSelectionTimeoutMS](https://docs.mongodb.com/master/reference/connection-string/) configuration variable and control the size of the acceptable latency window with the localThresholdMS configuration variable.

You can find our implementation of this algorithm in the `MongoServerSelection` class.
The default parameters for the selection is customizable via `localThreshold:`, `readPreference:` and `serverSelectionTimeout:` in the `MongoClientSettings` instance (accessed via `MongoClient>>settings`).
However, several selection parameters may be specialized for each operation with:
```Smalltalk
client
	mongoDo: [ :mongo | "do some operation on the Mongo object here" ]
	readPreference: MongoReadPreference newNearest
	localThreshold: 100 milliseconds
```

## Connection Pooling

The MongoDB specification makes some suggestions and requirements for drivers on this connection pooling characteristics on [this document](https://github.com/mongodb/specifications/blob/master/source/connection-monitoring-and-pooling/connection-monitoring-and-pooling.rst).
You can find our implementation of this specification in the `MongoPool` class, which is customizable via `connectTimeout:`, `maxConnections:` and `socketTimeout:` in the `MongoClientSettings` instance (accessed via `MongoClient>>settings`).
When the application sends `mongoDo:` to the client, the pool will either reuse a cached `Mongo` instance (that was kept open) or create a new instance.
When the pool opens the socket to the server, it uses a timeout indicated by `connectTimeout`, and then sets the `socketTimeout` which applies to the database and collections read and write commands executed on it by the application.
Pools are initially empty: they grow when `mongoDo:` succeed, and are emptied when a connection error is handled.
They only grow up to the quantity indicated by `maxConnections`; when such upper bound is exceeded, the connections are closed when returned by the application.


## What's not implemented?

This is only a partial implementation of the whole MongoDB specification.

For example, our `MongoClient` doesn't provide any direct read or write operation (as the specification requires).
Instead, such operations are supported by first obtaining an instance of `Mongo` (the connection to a particular server) and then obtaining the db/collection to perform the operations.

Current implementation lacks ReplicaSet support.
