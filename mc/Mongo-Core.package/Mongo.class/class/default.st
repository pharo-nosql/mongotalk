accessing
default
	"If there is no other default use the local one"
	
	^Default ifNil: [ Default := self local ]