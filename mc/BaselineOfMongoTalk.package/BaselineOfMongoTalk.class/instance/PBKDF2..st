external projects
PBKDF2: spec
	spec
		baseline: 'Cryptography' with: [ 
			spec 
				repository: 'github://pharo-contributions/Cryptography:0.5/source' ];
			
		project: 'PBKDF2' copyFrom: 'Cryptography' with: [ 
				 spec loads: 'PBKDF2'  ]