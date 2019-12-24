accessing
name
	^ 'Monitor {1} - client {2}'
		format:
			{urlString.
			client identityHash}