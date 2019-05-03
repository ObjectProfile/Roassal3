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
		'lowColor'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSLabeled >> createLabel: anElement [
	| label v color set |
	label := shape elementOn: anElement model.
	location stick: label on: anElement.
	v := anElement view.
	v add: label.
	anElement attributes at: #RSLabeled put: label.
	isHighlightable ifFalse: [ ^ self ].
	color := label color.
	label color: self lowColor.
	set := [ :c | label pushFront; color: c; signalUpdate ].
	anElement 
		when: TSMouseEnter do: [ set value: color ];
		when: TSMouseLeave do: [ set value: lowColor ].
]

{ #category : #'public - configuration' }
RSLabeled >> highlightable [
	isHighlightable := true
]

{ #category : #initialization }
RSLabeled >> initialize [ 
	super initialize.
	shape := RSShapeBuilder label.
	location := RSLocate new above.
	isHighlightable := false.
]

{ #category : #accessing }
RSLabeled >> location [
	^ location
]

{ #category : #accessing }
RSLabeled >> lowColor [
	^ lowColor ifNil: [ lowColor := Color veryVeryLightGray ].
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
