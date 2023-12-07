"
When the uml is open, this class will move the target class of the canvas, in one second
"
Class {
	#name : 'RSDancingSelection',
	#superclass : 'RSInitialSelection',
	#category : 'Roassal-UML-Calypso-Utilities',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
RSDancingSelection >> on: aCanvas [
	| shape p d|
	shape := aCanvas shapeFromModel: self targetClass.
	(shape isNil or: [ aCanvas nodes size < 3 ]) ifTrue: [ ^ self ].
	p := shape position.
	d := 20.
	aCanvas newAnimation
		duration: 1 second;
		scale: (NSScale linear
			domain: #(0 0.25 0.5 0.75 1);
			range: {p. p+d. p. p+d. p});
		on: shape set: #translateTo: .
]
