accessing
counterNext 
	"increase the 24 bit counter and return"
	^ counter := counter 
						ifNil:[counter := self newCounter] 
						ifNotNil:[counter + 1 \\ 16rFFFFFF]