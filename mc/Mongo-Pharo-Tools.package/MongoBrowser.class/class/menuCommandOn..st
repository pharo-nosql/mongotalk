world menu
menuCommandOn: aBuilder 
	<worldMenu> 
	(aBuilder item: #'Mongo Browser')
		parent: #Tools;
		action: [self open]; 
		icon: Smalltalk ui icons mongoIcon