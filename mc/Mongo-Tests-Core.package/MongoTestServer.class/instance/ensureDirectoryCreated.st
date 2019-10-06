private
ensureDirectoryCreated
	self directoryString asFileReference
		ensureDeleteAll;
		ensureCreateDirectory