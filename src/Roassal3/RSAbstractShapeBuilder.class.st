"
I am base class for builders with interactions
"
Class {
	#name : #RSAbstractShapeBuilder,
	#superclass : #RSAbstractModelBuilder,
	#instVars : [
		'interaction'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
RSAbstractShapeBuilder >> draggable [
	self interactionDo: #draggable.
]

{ #category : #interactions }
RSAbstractShapeBuilder >> interaction [
	^ interaction ifNil: [
		interaction := RSInteractionBuilder new.
		self addAction: (RSAction new
			action: [ :el | interaction setUpElement: el ]).
		interaction ].
]

{ #category : #interactions }
RSAbstractShapeBuilder >> interactionDo: aBlock [
	aBlock value: self interaction
]

{ #category : #interactions }
RSAbstractShapeBuilder >> popup [
	self interactionDo: #popup.
]

{ #category : #updating }
RSAbstractShapeBuilder >> updateElement: element [
	self 
		updateElement: element 
		innerComponent: element shape
]

{ #category : #updating }
RSAbstractShapeBuilder >> updateElement: element withCommand: selector [
	| temp |
	temp := commands.
	commands := commands select: [ :c | c selector = selector ].
	self updateElement: element.
	commands := temp.
		
]

{ #category : #updating }
RSAbstractShapeBuilder >> updateElements: elements [
	elements do: [ :e | self updateElement: e ].
]
