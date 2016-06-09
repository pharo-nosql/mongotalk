writing
nextAssociationPut: anAssociation 
	stream nextBytePut: (self typeCode: anAssociation value).
	self nextStringPut: anAssociation key.
	anAssociation value writeBSONOn: self