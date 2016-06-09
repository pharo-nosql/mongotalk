versions
v1_9_5: spec
	<version: 'v1.9.5'>

	spec
		for: #'common'
		do: [ 
			spec
				baseline: 'MongoTalk'
					with: [ spec repository: 'github://pharo-nosql/mongotalk:v1.9.5/mc' ];
				import: 'MongoTalk' ].