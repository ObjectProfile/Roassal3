"
I am the base for attach points
"
Class {
	#name : #RSAttachPoint,
	#superclass : #RSObject,
	#instVars : [
		'inverted'
	],
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'instance creation' }
RSAttachPoint class >> centered [
	^ RSCenteredAttachPoint new
]

{ #category : #'public - hooks' }
RSAttachPoint >> basicEndingPointOf: anEdge [
	^ self subclassResponsibility 
]

{ #category : #'public - hooks' }
RSAttachPoint >> basicStartingPointOf: anEdge [
	^ self subclassResponsibility 
]

{ #category : #'public - hooks' }
RSAttachPoint >> endingPointOf: aLine [
	"Return the end point of a line.
	
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSBorderAttachPoint new.
	l update.
	b1 @ RSDraggable.
	b2 @ RSDraggable.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	
	l attachPoint startingPointOf: l
=> 	50 @ 45
	"
	(aLine from = aLine to) 
		ifTrue: [ ^ self position: aLine from ].
    ^ inverted
        ifTrue: [ self basicStartingPointOf: aLine ]
        ifFalse: [ self basicEndingPointOf: aLine ]
]

{ #category : #'public - hooks' }
RSAttachPoint >> initialize [
	super initialize.
	inverted := false.
]

{ #category : #private }
RSAttachPoint >> position: aShapeOrAPoint [
	"Return the position of a shape. Polymorphic to point"
	aShapeOrAPoint isPoint ifTrue: [ ^ aShapeOrAPoint ].
	^ self positionFor: aShapeOrAPoint point: aShapeOrAPoint position.
]

{ #category : #private }
RSAttachPoint >> positionFor: aShape point: aPoint [
	^ aPoint
]

{ #category : #'public - hooks' }
RSAttachPoint >> startingPointOf: aLine [
"Return the starting point of a line.
	
	b1 := RSBox new size: 20.
	b2 := RSBox new size: 20.
	b1 translateTo: 20 @ 30.
	b2 translateTo: 60 @ 50.
	l := RSLine new
		from: b1;
		to: b2.
	l attachPoint: RSBorderAttachPoint new.
	l update.
	b1 @ RSDraggable.
	b2 @ RSDraggable.
	c := RSCanvas new.
	c
		add: b1;
		add: b2;
		add: l.
	
	l attachPoint startingPointOf: l
=> 	30 @ 35
	"
	(aLine from = aLine to) 
		ifTrue: [ ^ self position: aLine from ].
    ^ inverted
        ifTrue: [ self basicEndingPointOf: aLine ]
        ifFalse: [ self basicStartingPointOf: aLine ]

]
