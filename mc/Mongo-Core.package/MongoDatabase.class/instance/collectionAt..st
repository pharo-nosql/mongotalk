accessing
collectionAt: aString 
	"Answers the collection in this database that has aString as name (or nil)"

	^ self collections 
		detect:  [ :e | e name = aString ]
		ifNone: [ nil ]