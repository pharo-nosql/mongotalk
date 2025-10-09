Class {
	#name : 'MongoCCommandError',
	#superclass : 'MongoCommandError',
	#instVars : [
		'code'
	],
	#category : 'Mongo-DriverC-Base',
	#package : 'Mongo-DriverC',
	#tag : 'Base'
}

{ #category : 'signalling' }
MongoCCommandError class >> signalFor: aBsonTError [
	"I cannot keep the bson error directly because this is an external object and 
	 it must (and will) be destroyed and collected."

	^ self new 
		code: aBsonTError code;
		messageText: aBsonTError messageString;
		signal
]

{ #category : 'accessing' }
MongoCCommandError >> code [

	^ code
]

{ #category : 'accessing' }
MongoCCommandError >> code: aNumber [ 

	code := aNumber
]

{ #category : 'accessing' }
MongoCCommandError >> codeIfPresent: presentBlock ifAbsent: absentBlock [

	^ code 
		ifNotNil: [ presentBlock cull: code ]
		ifNil: absentBlock
]

{ #category : 'testing' }
MongoCCommandError >> isCollectionAlreadyExists [

	^ false
]

{ #category : 'accessing' }
MongoCCommandError >> messageText [

	^ messageText
]
