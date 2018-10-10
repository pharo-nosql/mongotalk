external projects
PBKDF2: spec
	spec
		baseline: 'Cryptography' with: [ 
			spec 
				repository: 'github://pharo-contributions/Cryptography:0.3.1/source' ];
			
		project: 'PBKDF2' copyFrom: 'Cryptography' with: [ 
				 spec loads: 'PBKDF2'  ]