private
newOpenMongo
	^ (Mongo url: url)
		open;
		yourself