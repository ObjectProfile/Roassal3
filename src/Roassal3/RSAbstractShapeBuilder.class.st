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
