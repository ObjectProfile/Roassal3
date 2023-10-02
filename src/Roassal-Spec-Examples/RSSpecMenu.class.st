"
I all some menus in 'Tools-Roassal' for these examples
"
Class {
	#name : #RSSpecMenu,
	#superclass : #RSObject,
	#category : #'Roassal-Spec-Examples-Menu'
}

{ #category : #menu }
RSSpecMenu class >> classAt: aSymbol [
	^ self class environment at: aSymbol 
]

{ #category : #testing }
RSSpecMenu class >> hasClasses: classes [
	^ classes allSatisfy: [:k | Smalltalk globals includesKey: k ]
]

{ #category : #menu }
RSSpecMenu class >> menu07Examples: aBuilder [	<worldMenu>
	| icon |
	(self hasClasses: #(RSExamplesBrowser RSWorldMenu))
		ifFalse: [ ^ self ].
	icon :=  (self classAt:#RSWorldMenu) roassalIcon.
	(aBuilder item: #RoassalExamples)
		parent: #Roassal;
		order: 5;
		label: 'Examples';
		help: 'Check some examples of roassal with spec';
		icon: icon.

	(aBuilder item: #RoassalExamplesBrowser)
		parent: #RoassalExamples;
		order: 1;
		label: 'Examples Browser';
		help: 'Open a browser to jump between examples';
		icon: icon;
		action: [ (self classAt: #RSExamplesBrowser) new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu08PalettesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #RoassalPalettes)
		parent: #RoassalExamples;
		order: 7;
		label: 'Color palettes';
		help: 'Open a color palette chooser';
		icon: (self iconNamed: #paint);
		action: [ (self classAt: #RSColorPaletteChooser) new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu09EaselOn: aBuilder [
	<worldMenu>
	(aBuilder item: #RoassalEasel)
		parent: #RoassalExamples;
		order: 7.1;
		label: 'Easel';
		help: 'Open a basic window to edit a Roassal script';
		icon: (self iconNamed: #haloPaint);
		action: [ (self classAt: #RSEasel) new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu10IconsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #RoassalIcons)
		parent: #RoassalExamples;
		order: 7.2;
		label: 'Icons';
		help: 'Visit some icons of the pharo system';
		icon: (self iconNamed: #versionControl);
		action: [ RSIconBrowser new open ]
]

{ #category : #menu }
RSSpecMenu class >> menu11LayoutStudioOn: aBuilder [
	<worldMenu>
	(aBuilder item: #RoassalLayoutStudio)
		parent: #RoassalExamples;
		order: 7.3;
		label: 'Layout Studio';
		help: 'Edit some layout properties and check the result';
		icon: (self iconNamed: #references);
		action: [ (self classAt: #RSLayoutStudio) new open ]
]
