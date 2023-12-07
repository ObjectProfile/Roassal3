"
Highlight the target class from the canvas to a darker color in one second
"
Class {
	#name : 'RSColorSelection',
	#superclass : 'RSInitialSelection',
	#category : 'Roassal-UML-Calypso-Utilities',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
RSColorSelection >> on: aCanvas [
	| shape c1 c2 |
	shape := aCanvas shapeFromModel: self targetClass.
	(shape isNil or: [ aCanvas nodes size < 3 ]) ifTrue: [ ^ self ].
	shape := shape children first.
	c1 := shape color.
	c2 := c1 muchDarker.
	aCanvas newAnimation
		duration: 1 second;
		scale: (NSScale linear
			domain: #(0 0.25 0.5 0.75 1);
			range: {c1. c2. c1. c2. c1});
		on: shape set: #color:.
]
