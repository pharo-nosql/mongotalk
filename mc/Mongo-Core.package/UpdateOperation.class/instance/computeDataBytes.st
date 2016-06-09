writing
computeDataBytes
	^ BSON writeAll: (Array 
		with: originalObject
		with: newObject)