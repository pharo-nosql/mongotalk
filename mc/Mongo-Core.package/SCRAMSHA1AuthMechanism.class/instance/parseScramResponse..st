private
parseScramResponse: payload
	"
	Parse response from ByteArray to Dictinary
	payload example:
	'r=NDQwNDY0NjUxNDE3MjAzNTM=D06U34OmY+NSiHeqb5LlQQ==,s=xyBf9wy9k94L7Zn+6A6UXg==,i=10000'
	output: { r->'NDQ...'. s->'xy...'. i->10000 } asDictionary"

	^ ((payload asString substrings: ',')
		collect: [ :each | each first asString -> (each copyFrom: 3 to: each size) ])
		asDictionary