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

{ #category : #accessing }
RSAbstractShapeBuilder >> interaction [
	^ interaction ifNil: [
		interaction := RSInteractionBuilder new.
		self addAction: (RSAction new
			action: [ :el | interaction setUpElement: el ]).
		interaction ].
]

{ #category : #accessing }
RSAbstractShapeBuilder >> interactionDo: aBlock [
	aBlock value: self interaction
]

{ #category : #accessing }
RSAbstractShapeBuilder >> updateElement: element [

	self updateElement: element innerComponent: element trachelShape
]
