"
I am the base for attach points
"
Class {
	#name : #RSAttachPoint,
	#superclass : #RSObject,
	#instVars : [
		'inverted'
	],
	#category : #'Roassal3-Shapes-AttachPoint'
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

{ #category : #private }
RSAttachPoint >> commonParents: shape in: anEdge [
	| current parents |
	current := shape parent.
	parents := OrderedCollection new.
	[ current = anEdge parent ] whileFalse: [ 
		current ifNil: [ ^ nil ].
		current parent = current ifTrue: [ ^ nil ].
		parents add: current.
		current := current parent ].
	^ parents
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
		ifTrue: [ ^ self positionFor: aLine from in: aLine ].
    ^ inverted
        ifTrue: [ self basicStartingPointOf: aLine ]
        ifFalse: [ self basicEndingPointOf: aLine ]
]

{ #category : #private }
RSAttachPoint >> hasParents: shape in: anEdge [
	^ shape parent notNil and: [ anEdge parent notNil ]
]

{ #category : #'public - hooks' }
RSAttachPoint >> initialize [
	super initialize.
	inverted := false.
]

{ #category : #private }
RSAttachPoint >> matrixFor: commonParents [
	| matrix |
	matrix := AthensAffineTransform new.
	commonParents reverseDo: [ :s | matrix multiplyBy: s matrix ].
	^ matrix
]

{ #category : #private }
RSAttachPoint >> positionFor: shape in: anEdge [
	shape isPoint ifTrue: [ ^ shape ].
	^ self positionFor: shape in: anEdge point: shape position
]

{ #category : #private }
RSAttachPoint >> positionFor: shape in: anEdge point: pos [
	| commonParents |
	shape isPoint ifTrue: [ ^ shape ].
	(self hasParents: shape in: anEdge) ifFalse: [ ^ pos ].
	shape parent = anEdge parent ifTrue: [ ^ pos ].
	
	"TODO we can cache this info"
	commonParents := self commonParents: shape in: anEdge.
	commonParents ifNil: [ ^ pos ].
	^ (self matrixFor: commonParents) transform: pos. 
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
		ifTrue: [ ^ self positionFor: aLine from in: aLine ].
    ^ inverted
        ifTrue: [ self basicEndingPointOf: aLine ]
        ifFalse: [ self basicStartingPointOf: aLine ]

]
