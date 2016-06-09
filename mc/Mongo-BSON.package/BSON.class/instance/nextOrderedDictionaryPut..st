writing
nextOrderedDictionaryPut: aDictionary
	"write associations as they are in the dictionary. This supports dictionaries that
	have special order.  Mongo is looking up some of the key-value based collections 
	in order and not by key. This is rather important for dictionaries that form queries 
	than for the ones that are supposed to be stored"
	self basicNextDictionaryPut:  aDictionary associations