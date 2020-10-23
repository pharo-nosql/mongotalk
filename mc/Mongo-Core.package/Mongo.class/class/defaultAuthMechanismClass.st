accessing
defaultAuthMechanismClass
	"Answer a subclass of MongoAuthMechanism that represents the default authentication mechanism for a Mongo instance.
	
	See: https://docs.mongodb.com/v4.0/core/authentication-mechanisms/
	"

	^ defaultAuthMechanismClass ifNil: [ SCRAMSHA1AuthMechanism ]