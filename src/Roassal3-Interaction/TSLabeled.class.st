"
A RSLabeled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. 

"
Class {
	#name : #TSLabeled,
	#superclass : #TSInteraction,
	#instVars : [
		'shape',
		'location',
		'isHighlightable',
		'lowColor',
		'target',
		'modelBlock'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
TSLabeled >> createLabel: anElement [
	| label color set targetLabel |
	label := shape elementOn: (self modelFor: anElement).
	location stick: label on: anElement.
	isHighlightable 
		ifFalse: [ ^ label ].
	targetLabel := target value: label.
	color := targetLabel color.
	targetLabel color: self lowColor.
	set := [ :c | 
		label pushFront.
		targetLabel color: c.
		label signalUpdate ].
	anElement 
		when: TSMouseEnter do: [ set value: color ];
		when: TSMouseLeave do: [ set value: lowColor ];
		when: TSShapeRemovedEvent do: [ label remove ].
	^ label
]

{ #category : #hooks }
TSLabeled >> getOrCreateLabel: aShape [
	| label parent |
	label := aShape attributes 
		at: #TSLabeled
		ifAbsentPut: [ self createLabel: aShape ].
	parent :=aShape parent.
	(label isInACanvas not and: [parent notNil ]) 
		ifTrue: [ parent addShape: label shape ].
	^ label
]

{ #category : #'public - configuration' }
TSLabeled >> highlightable [
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
TSLabeled >> initialize [ 
	super initialize.
	self shape: RSShapeBuilder label.
	self model: #model.
	location := RSLocation new above.
	isHighlightable := false.
]

{ #category : #accessing }
TSLabeled >> location [
	^ location
]

{ #category : #accessing }
TSLabeled >> lowColor [
	^ lowColor
]

{ #category : #accessing }
TSLabeled >> lowColor: aColor [
	lowColor := aColor
]

{ #category : #accessing }
TSLabeled >> model [
	^ modelBlock
]

{ #category : #accessing }
TSLabeled >> model: aBlock [
	modelBlock := aBlock
]

{ #category : #hooks }
TSLabeled >> modelFor: anElement [
	^ modelBlock rsValue: anElement.
]

{ #category : #hooks }
TSLabeled >> onShape: aShape [
	| block |
	block := [ self getOrCreateLabel: aShape. ]. 
	aShape isInACanvas 
		ifTrue: block
		ifFalse: [ aShape when: TSShapeAddedEvent do: block ].
]

{ #category : #accessing }
TSLabeled >> shape [
	^ shape
]

{ #category : #accessing }
TSLabeled >> shape: aShapeBuilder [
	shape := aShapeBuilder
]

{ #category : #accessing }
TSLabeled >> target [
	^ target
]

{ #category : #accessing }
TSLabeled >> target: aBlock [
	target := aBlock
]

{ #category : #'public - configuration' }
TSLabeled >> text: aBlockOrSymbol [
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
	self shape: (RSShapeBuilder label text: aBlockOrSymbol).

]
