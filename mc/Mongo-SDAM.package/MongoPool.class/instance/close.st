accessing
close
	"Remove and close all connections."
	
	mutex critical: [
		[ connections isEmpty ] whileFalse: [
			connections removeLast closeIfOpen ]]