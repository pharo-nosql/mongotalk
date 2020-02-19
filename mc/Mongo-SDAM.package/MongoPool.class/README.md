A pool of Mongo instances.

I use a mutex to synchronize manipulation of connections (my collection of Mongo instances).

I use a semaphore initialized with the same number of excess signals that maxConnections. Read more on #mongoDo: and #next.

See: https://github.com/mongodb/specifications/blob/03aed6c58dcd6afd81980876be2042afc45d06d3/source/connection-monitoring-and-pooling/connection-monitoring-and-pooling.rst
