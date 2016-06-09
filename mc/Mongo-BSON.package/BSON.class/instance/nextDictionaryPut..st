writing
nextDictionaryPut: aDictionary
	"write associations sorted and having the _id field in first place. This is kept for 
	legacy reasons although the necessity for having fields sorted is not obvious"
	self basicNextDictionaryPut: (
		aDictionary associations 
			asSortedCollection: [:a :b | a key = '_id' | (a key < b key)]) 