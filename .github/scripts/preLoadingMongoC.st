Stdio stdout << (FFIUnix64LibraryFinder newfindLibrary: 'libmongoc-1.0.so'); lf; flush.
Stdio stdout << (FFIUnix64LibraryFinder newfindLibrary: 'libbson-1.0.so'); lf; flush.


"I require this in older versions "
SystemVersion current major < 14 ifTrue: [
	Metacello new
		repository: 'github://pharo-cig/UnifiedFFI:v1.2';
		baseline: 'UnifiedFFIFull';
		onConflict: [ :n | n useIncoming ];
		onUpgrade: [ :n | n useIncoming ];
		ignoreImage;
		load.
	Metacello new baseline: #UnifiedFFIFull; lock 
].
