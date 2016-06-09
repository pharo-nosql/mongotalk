versions
dev: spec
	<version: 'dev'>

	spec
		for: #'common'
		do: [ 
			spec
				baseline: 'MongoTalk'
					with: [ spec repository: 'github://pharo-nosql/mongotalk/mc' ];
				import: 'MongoTalk' ].