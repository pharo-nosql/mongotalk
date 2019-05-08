initialization
canonicalMongoUrlAsString: url
	"Convert an url to String in the same format that ismaster->hosts uses with the purpose of comparing fast."

	| aZnUrl |
	aZnUrl := url asMongoUrl.
	^ aZnUrl host , ':' , aZnUrl port asString