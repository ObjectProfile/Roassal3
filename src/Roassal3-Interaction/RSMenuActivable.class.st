"
With the mouse right click event I show a basic popup

Example:
-=-=-=-=
v := RSView new.

boxes := RSShapeBuilder composite
				color: Color blue trans;
				shapes: [ :nb | 
					TSGroup with: (RSShapeBuilder label elementOn: nb)
					 ]; 
				size: 30;
				elementsOn: (1 to: 100).
v addAll: boxes.
RSGridLayout on: boxes.
boxes @ (RSMenuActivable new menuDo: [ :menu :element | menu add: 'Inspect' target: element model selector: #inspect ]).
v @ RSControlsView.
v open
-=-=-=-=
"
Class {
	#name : #RSMenuActivable,
	#superclass : #RSInteraction,
	#instVars : [
		'menuBlock'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #enumerating }
RSMenuActivable >> menuDo: block [
	"a block with two args
	first arg, a MenuMorph
	second arg, a RSElement or RSView
	"
	menuBlock := block
]

{ #category : #hooks }
RSMenuActivable >> onShape: aShape [
	"No need to do anything if empty"
	menuBlock isNil ifTrue: [ ^ self ].
	aShape when: RSMouseRightClick do: [ :evt | 
		| menu |
		menu := MenuMorph new.
		menuBlock value: menu value: evt shape.
		menu popUpInWorld ].
	
]
