versions
version12: spec
	<version: '1.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'updated to newer versions'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '6/5/2012 17:33'.
		spec project: 'Grease' with: #'stable'.
		spec 
			package: 'Mongo-Squeak' with: 'Mongo-Squeak-NorbertHartl.0.12';
			package: 'Mongo-BSON' with: 'Mongo-BSON-NicolasPetton.29';
			package: 'Mongo-Core' with: 'Mongo-Core-NicolasPetton.22'. ].
