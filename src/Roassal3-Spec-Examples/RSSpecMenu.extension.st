Extension { #name : #RSSpecMenu }

{ #category : #'*Roassal3-Spec-Examples' }
RSSpecMenu classSide >> menu07PalettesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 7;
		label: 'Color palettes';
		help: 'Open a color palette chooser';
		icon: (self iconNamed: 'paint');
		action: [ RSColorPaletteChooser new openWithSpec ]
]

{ #category : #'*Roassal3-Spec-Examples' }
RSSpecMenu classSide >> menu12PalettesOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 7.1;
		label: 'Easel';
		help: 'Open a basic window to edit a roassal3 script';
		icon: (self iconNamed: 'haloPaint');
		action: [ RSEasel new open ]
]
