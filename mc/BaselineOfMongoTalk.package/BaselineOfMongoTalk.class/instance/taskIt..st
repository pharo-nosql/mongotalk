external projects
taskIt: spec
	spec baseline: 'TaskIt' with: [
		spec
			repository: 'github://pharo-contributions/taskit:v1.1.1';
			loads: #(core) ]
