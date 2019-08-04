accessing
collectionAt: aString 
	"Answers a MongoCollection for this database that has aString as name (may not exist)."

	^ MongoCollection database: self name: aString