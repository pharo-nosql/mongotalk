accessing
maxConnections: aQuantity
	maxConnections := aQuantity.
	monitors do: [ :each | each pool maxConnections: aQuantity ]