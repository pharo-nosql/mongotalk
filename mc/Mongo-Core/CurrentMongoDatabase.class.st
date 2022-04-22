"
CurrentMongoDatabase is the dynamic variable that will give you the database currently being used.

The value of this variable is going to be the database when you perform:

	aDatabase do:[
		""some database actions""]
	
everything inside that code will have access to aDatabase by calling 'CurrentMongoDatabase value' 
"
Class {
	#name : #CurrentMongoDatabase,
	#superclass : #DynamicVariable,
	#category : 'Mongo-Core-Utilities'
}
