Extension { #name : #DateAndTime }

{ #category : #'*Mongo-BSON' }
DateAndTime >> asBSONMilliSeconds [
	| dateAndTimeUTC |

	dateAndTimeUTC := self asUTC.
	^ dateAndTimeUTC asDate asBSONMilliSeconds + dateAndTimeUTC asTime asMilliSeconds
]
