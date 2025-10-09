Trait {
	#name : 'MongoTSocket',
	#instVars : [
		'stream'
	],
	#category : 'Mongo-Core-Base',
	#package : 'Mongo-Core',
	#tag : 'Base'
}

{ #category : 'accessing' }
MongoTSocket >> close [

	stream close
]

{ #category : 'testing' }
MongoTSocket >> isOpen [ 

	^ stream notNil and: [ stream isConnected ]
]

{ #category : 'accessing' }
MongoTSocket >> openFor: aMongo [

	stream := SocketStream openConnectionToHostNamed: aMongo host port: aMongo port.
	stream binary.
	stream socket 
		setOption: 'TCP_NODELAY' 
		value: 1
]

{ #category : 'accessing' }
MongoTSocket >> openFor: aMongo timeout: aDuration [ 
	| addr |

	"Waits the specified number of seconds to open the connection."
	addr := NetNameResolver addressForName: aMongo host timeout: 20.
	stream := SocketStream 
		openConnectionToHost: addr 
		port: aMongo port 
		timeout: aDuration asSeconds.
	stream socket setOption: 'TCP_NODELAY' value: 1.
	stream binary.
	
	stream timeout: aDuration asSeconds
]

{ #category : 'accessing' }
MongoTSocket >> stream [

	^ stream
]

{ #category : 'accessing' }
MongoTSocket >> stream: aStream [

	stream := aStream
]
