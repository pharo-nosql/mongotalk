writing
writeHeader
	writer
		nextInt32Put: self messageSize;
		nextInt32Put: id;
		nextInt32Put: 0;
		nextInt32Put: self opCode