versions
version192: spec
	<version: '1.9.2' imports: #('1.9-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'created MongoTimeStamp'.
		spec author: 'MartinDias'.
		spec timestamp: '3/15/2016 23:55'.
		spec project: 'Grease' with: '1.1.9'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-MartinDias.18';
			package: 'Mongo-BSON' with: 'Mongo-BSON-MartinDias.45';
			package: 'Mongo-Core' with: 'Mongo-Core-HolgerHansPeterFreyther.48';
			package: 'Mongo-Queries' with: 'Mongo-Queries-TorstenBergmann.1';
			package: 'Mongo-Tests-BSON' with: 'Mongo-Tests-BSON-MartinDias.2';
			package: 'Mongo-Tests-Core' with: 'Mongo-Tests-Core-HolgerHansPeterFreyther.3';
			package: 'Mongo-Tests-Queries' with: 'Mongo-Tests-Queries-TorstenBergmann.2';
			package: 'Mongo-Pharo-Tools' with: 'Mongo-Pharo-Tools-TorstenBergmann.7'.

		].
