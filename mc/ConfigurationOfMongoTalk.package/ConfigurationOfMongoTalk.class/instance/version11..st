versions
version11: spec
	<version: '1.1' imports: #('1.0') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.0.12';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NorbertHartl.25' ].