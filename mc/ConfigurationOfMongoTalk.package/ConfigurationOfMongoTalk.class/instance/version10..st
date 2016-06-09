versions
version10: spec
	<version: '1.0' imports: #('1.0-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-EstebanLorenzano.0.8';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NicolasPetton.21';
			package: 'Mongo-Core' with: 'Mongo-Core-NicolasPetton.21' ].