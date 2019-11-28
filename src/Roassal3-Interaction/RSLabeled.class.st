"
A RSLabeled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. 

"
Class {
	#name : #RSLabeled,
	#superclass : #RSInteraction,
	#instVars : [
		'location',
		'isHighlightable',
		'lowColor',
		'target',
		'modelBlock',
		'shapeBuilder'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSLabeled >> createLabel: anElement [
	| label color set targetLabel |
	label := self shapeBuilder shapeFor: (self modelFor: anElement).
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
		when: RSMouseEnter do: [ set value: color ];
		when: RSMouseLeave do: [ set value: lowColor ];
		when: RSShapeRemovedEvent do: [ label remove ].
	^ label
]

{ #category : #hooks }
RSLabeled >> getOrCreateLabel: aShape [
	| label parent |
	label := aShape attributes 
		at: #RSLabeled
		ifAbsentPut: [ self createLabel: aShape ].
	parent :=aShape parent.
	(label isInACanvas not and: [parent notNil ]) 
		ifTrue: [ parent addShape: label shape ].
	^ label
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
	self shapeBuilder: [:model |RSShape label text: model ].
	self model: #model.
	location := RSLocation new above.
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

{ #category : #accessing }
RSLabeled >> model [
	^ modelBlock
]

{ #category : #accessing }
RSLabeled >> model: aBlock [
	modelBlock := aBlock
]

{ #category : #hooks }
RSLabeled >> modelFor: anElement [
	^ modelBlock rsValue: anElement.
]

{ #category : #hooks }
RSLabeled >> onShape: aShape [
	| block |
	block := [ self getOrCreateLabel: aShape. ]. 
	aShape isInACanvas 
		ifTrue: block
		ifFalse: [ aShape when: RSShapeAddedEvent do: block ].
]

{ #category : #accessing }
RSLabeled >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #accessing }
RSLabeled >> shapeBuilder: aShapeBuilder [
	shapeBuilder := aShapeBuilder
]

{ #category : #accessing }
RSLabeled >> target [
	^ target
]

{ #category : #accessing }
RSLabeled >> target: aBlock [
	target := aBlock
]

{ #category : #'public - configuration' }
RSLabeled >> text: aBlockOrSymbol [
	self shapeBuilder: [:model | RSShape label text: (aBlockOrSymbol rsValue: model)].

]
