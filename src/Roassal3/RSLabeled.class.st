"
A RSLabeled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. 
"
Class {
	#name : #RSLabeled,
	#superclass : #RSInteraction,
	#instVars : [
		'shape',
		'location'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSLabeled >> createLabel: anElement [
	| label v |
	label := shape elementOn: anElement model.
	location copy
		fix: anElement;
		movable: label;
		stick.
	v := anElement view.
	v add: label.
	anElement attributes at: #RSLabeled put: label.
]

{ #category : #initialization }
RSLabeled >> initialize [ 
	super initialize.
	shape := RSShapeBuilder label.
	location := RSLocate new above.
]

{ #category : #accessing }
RSLabeled >> location [
	^ location
]

{ #category : #hooks }
RSLabeled >> onElement: anElement [
	| block |
	block := [ self createLabel: anElement ]. 
	anElement isInACanvas 
		ifTrue: block
		ifFalse: [ anElement when: TSShapeAddedEvent do: block ].
]

{ #category : #accessing }
RSLabeled >> shape [
	^ shape
]
