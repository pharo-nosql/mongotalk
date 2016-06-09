versions
version194: spec
	<version: '1.9.4' imports: #('1.10-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'NorbertHartl introduced MongoCollectionAlreadyExists error. It is thrown when the collection that should be created already exists. There is a new method getCollection: that just ignores the error and returns the collection. So Voyage should use getCollection: in the resolver to retrieve the collection. In mongo the collection is created anyway whenever accessed first. So that should be as close to mongo as possible'.
		spec author: 'MartinDias'.
		spec timestamp: '3/26/2016 14:25'.
		spec project: 'Grease' with: '1.2.6'.
		spec 
			package: 'Mongo-BSON' with: 'Mongo-BSON-MartinDias.45';
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-MartinDias.18';
			package: 'Mongo-Core' with: 'Mongo-Core-NorbertHartl.50';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-MartinDias.2';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-NorbertHartl.4';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.7'. ].
