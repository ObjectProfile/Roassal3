Extension { #name : #RSWorldMenu }

{ #category : #'*Roassal3-Spec-Examples' }
RSWorldMenu class >> menu07PalettesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 7;
		label: 'Color palettes';
		icon: (self iconNamed: 'paint');
		action: [ RSColorPaletteChooser new openWithSpec ]
]

{ #category : #'*Roassal3-Spec-Examples' }
RSWorldMenu class >> menu12PalettesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3;
		order: 12;
		label: 'Easel';
		icon: (self iconNamed: 'haloPaint');
		action: [ RSEasel new openWithSpec ]
]
