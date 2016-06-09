logical operation
not
	^ self copy 
		conditions: (self conditions collect: [ :each | each not ]);
		yourself