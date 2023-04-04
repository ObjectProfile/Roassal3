"
I all some menus in 'Tools-Roassal3' for these examples
"
Class {
	#name : #RSSpecMenu,
	#superclass : #RSObject,
	#category : #'Roassal3-Spec-Examples-Basic'
}

{ #category : #menu }
RSSpecMenu class >> menu07Examples: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Examples)
		parent: #Roassal3;
		order: 5;
		label: 'Examples';
		help: 'Check some examples of roassal with spec';
		icon: RSWorldMenu roassalIcon.

	(aBuilder item: #Roassal3ExamplesBrowser)
		parent: #Roassal3Examples;
		order: 1;
		label: 'Examples Browser';
		help: 'Open a browser to jump between examples';
		icon: RSWorldMenu roassalIcon;
		action: [ RSExamplesBrowser new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu08PalettesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Palettes)
		parent: #Roassal3Examples;
		order: 7;
		label: 'Color palettes';
		help: 'Open a color palette chooser';
		icon: (self iconNamed: #paint);
		action: [ RSColorPaletteChooser new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu09EaselOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Easel)
		parent: #Roassal3Examples;
		order: 7.1;
		label: 'Easel';
		help: 'Open a basic window to edit a roassal3 script';
		icon: (self iconNamed: #haloPaint);
		action: [ RSEasel new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu10IconsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3Icons)
		parent: #Roassal3Examples;
		order: 7.2;
		label: 'Icons';
		help: 'Visit some icons of the pharo system';
		icon: (self iconNamed: #versionControl);
		action: [ RSIconBrowser new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu11LayoutStudioOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Roassal3LayoutStudio)
		parent: #Roassal3Examples;
		order: 7.3;
		label: 'Layout Studio';
		help: 'Edit some layout properties and check the result';
		icon: (self iconNamed: #references);
		action: [ RSLayoutStudio new open ]
]
