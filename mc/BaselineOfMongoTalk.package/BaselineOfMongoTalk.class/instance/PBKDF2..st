external projects
PBKDF2: spec
	spec
		baseline: 'Cryptography' with: [ 
			spec 
				repository: 'github://zweidenker/Cryptography:0.3/source' ];
			
		project: 'PBKDF2' copyFrom: 'Cryptography' with: [ 
				 spec loads: 'PBKDF2'  ]