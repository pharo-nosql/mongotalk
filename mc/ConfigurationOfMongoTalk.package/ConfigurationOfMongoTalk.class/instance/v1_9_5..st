versions
v1_9_5: spec
	<version: '1.9.5'>

	spec
		for: #'common'
		do: [ 
			spec
				baseline: 'MongoTalk'
					with: [ spec repository: 'github://pharo-nosql/mongotalk:1.9.5/mc' ];
				import: 'MongoTalk' ].