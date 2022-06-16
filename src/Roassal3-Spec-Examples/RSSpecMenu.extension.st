Extension { #name : #RSSpecMenu }

{ #category : #'*Roassal3-Spec-Examples' }
RSSpecMenu class >> menu07PalettesOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 7;
		label: 'Color palettes';
		help: 'Open a color palette chooser';
		icon: (self iconNamed: 'paint');
		action: [ RSColorPaletteChooser new open ]
]

{ #category : #'*Roassal3-Spec-Examples' }
RSSpecMenu class >> menu12PalettesOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 7.1;
		label: 'Easel';
		help: 'Open a basic window to edit a roassal3 script';
		icon: (self iconNamed: 'haloPaint');
		action: [ RSEasel new open ]
]
