"
A RSLabeled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. 

"
Class {
	#name : #RSLabeled,
	#superclass : #RSInteraction,
	#instVars : [
		'shape',
		'location',
		'isHighlightable',
		'lowColor',
		'target'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSLabeled >> createLabel: anElement [
	| label v color set targetLabel |
	label := shape elementOn: anElement.
	location stick: label on: anElement.
	v := anElement view.
	v add: label.
	anElement attributes at: #RSLabeled put: label.
	isHighlightable ifFalse: [ ^ self ].
	targetLabel := target value: label.
	color := targetLabel color.
	targetLabel color: self lowColor.
	set := [ :c | 
		label pushFront.
		targetLabel color: c.
		label signalUpdate ].
	anElement 
		when: TSMouseEnter do: [ set value: color ];
		when: TSMouseLeave do: [ set value: lowColor ].
]

{ #category : #'public - configuration' }
RSLabeled >> highlightable [
	"Make the label highlightable.
E.g.,

v := RSView new.

els := RSShapeBuilder box elementsOn: (1 to: 10).
v addAll: els.
els @ RSLabeled new highlightable.
RSNormalizer size elements: els; normalize: #yourself.
RSGridLayout on: els.
v @ RSControlsView.
v open
"
	isHighlightable := true.
	self 
		lowColor: Color veryVeryLightGray;
		target: #yourself.
]

{ #category : #initialization }
RSLabeled >> initialize [ 
	super initialize.
	shape := RSShapeBuilder label text: #model.
	location := RSLocate new above.
	isHighlightable := false.
]

{ #category : #accessing }
RSLabeled >> location [
	^ location
]

{ #category : #accessing }
RSLabeled >> lowColor [
	^ lowColor
]

{ #category : #accessing }
RSLabeled >> lowColor: aColor [
	lowColor := aColor
]

{ #category : #hooks }
RSLabeled >> onElement: anElement [
	| block |
	block := [ self createLabel: anElement. ]. 
	anElement isInACanvas 
		ifTrue: block
		ifFalse: [ anElement when: TSShapeAddedEvent do: block ].
]

{ #category : #accessing }
RSLabeled >> shape [
	^ shape
]

{ #category : #accessing }
RSLabeled >> shape: aShapeBuilder [
	shape := aShapeBuilder
]

{ #category : #accessing }
RSLabeled >> target [
	^ target
]

{ #category : #accessing }
RSLabeled >> target: aBlock [
	target := aBlock
]

{ #category : #initialization }
RSLabeled >> text: aBlockOrSymbol [
	"Set the transformation to be obtained
E.g.,

v := RSView new.
els := RSShapeBuilder box elementsOn: (1 to: 10).
v addAll: els.
els @ (RSLabeled new highlightable; text: [ :nb | nb model *10 ]).
RSNormalizer size elements: els; normalize: #yourself.
RSGridLayout on: els.
v @ RSControlsView.
v open

	"
	shape := RSShapeBuilder label text: aBlockOrSymbol.

]
