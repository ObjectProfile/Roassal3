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
boxes do: [ :b |
	b @ (RSMenuActivable new menuDo: [ :menu | menu add: 'Inspect' target: b selector: #inspect argument: #() ])
].
""boxes @ (RSMenuActivable new menuDo: [ :menu | menu add: 'Inspect' target: )""
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
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSMenuActivable >> highlightOn: evt [
 
	| att view |
	view := evt canvas view.
	view ifNil: [ ^ self ].
	att := view attributes.
	
	"The highlight attribute should contains an array {shape . originalColor}"
	(att includesKey: #highlight) ifTrue: [ self removeHighlightOn: evt ].
	
	att at: #highlight put: (Array with: evt shape with: evt shape color).
	evt shape color: Color red.
	view signalUpdate.
]

{ #category : #enumerating }
RSMenuActivable >> menuDo: block [
	menuBlock := block
]

{ #category : #hooks }
RSMenuActivable >> onElement: anElement [
	| remove |
	"No need to do anything if empty"
	menuBlock isNil ifTrue: [ ^ self ].
	
	anElement when: TSMouseRightClick do: [ :evt | 
		| menu |
		menu := MenuMorph new.
		menuBlock value: menu.
		menu popUpInWorld ].
	
	"No need to have highlight for a view"
	(anElement isKindOf: RSView) ifTrue: [ ^ self ]. 
	remove := [ :evt | self removeHighlightOn: evt ].
	anElement
		when: TSMouseClick do: remove;
		when: TSMouseEnter do: [ :evt | self highlightOn: evt ];
		when: TSMouseLeave do: remove;
		when: TSMouseDragging do: remove

]

{ #category : #hooks }
RSMenuActivable >> removeHighlightOn: evt [
 
	| att view |
	view := evt canvas view.
	view ifNil: [ ^ self ].
	att := view attributes.
	
	"The highlight attribute should contains an array {shape . originalColor}"
	(att includesKey: #highlight) ifFalse: [ ^ self ].
	(att at: #highlight) first color: (att at: #highlight) second. 
	att removeKey: #highlight.
	view signalUpdate.
]
