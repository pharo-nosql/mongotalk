accessing
majorVersion
	"Get the mongodb instance major version (e.g. 2 or 3) as integer. See #version"

	^ (self version splitOn: '.') first asInteger