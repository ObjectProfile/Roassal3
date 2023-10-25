"
I am the base for attach points
"
Class {
	#name : 'RSAttachPoint',
	#superclass : 'RSObject',
	#instVars : [
		'inverted'
	],
	#category : 'Roassal-Shapes-AttachPoint',
	#package : 'Roassal-Shapes',
	#tag : 'AttachPoint'
}

{ #category : 'instance creation' }
RSAttachPoint class >> centered [
	^ RSCenteredAttachPoint new
]

{ #category : 'examples' }
RSAttachPoint class >> example [
	| attachPoint c red blue line |
	attachPoint := RSBorderAttachPoint new.
	c := RSCanvas new.
	red := RSBox new
		size: 50;
		color: Color red;
		yourself.
	blue := RSBox new
		size: 50;
		color: Color blue;
		position: 100@100;
		yourself.
	line := RSLine new
		from: red;
		to: blue;
		attachPoint: RSBorderAttachPoint new;
		yourself.
	c add: red.
	c add: blue.
	c add: line.
	^ c open
]

{ #category : 'testing' }
RSAttachPoint class >> isAbstract [

	^ self == RSAttachPoint
]

{ #category : 'public - hooks' }
RSAttachPoint >> basicEndingPointOf: aLine [
	^ self subclassResponsibility
]

{ #category : 'public - hooks' }
RSAttachPoint >> basicStartingPointOf: aLine [
	^ self subclassResponsibility
]

{ #category : 'private' }
RSAttachPoint >> commonParents: shape in: aLine [
	| current parents |
	current := shape parent.
	parents := OrderedCollection new.
	[ current = aLine parent ] whileFalse: [
		current ifNil: [ ^ nil ].
		current parent = current ifTrue: [ ^ nil ].
		parents add: current.
		current := current parent ].
	^ parents
]

{ #category : 'public - hooks' }
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

{ #category : 'private' }
RSAttachPoint >> hasParents: shape in: aLine [
	^ shape parent notNil and: [ aLine parent notNil ]
]

{ #category : 'initialization' }
RSAttachPoint >> initialize [
	super initialize.
	inverted := false
]

{ #category : 'public' }
RSAttachPoint >> inverted [
	inverted := true
]

{ #category : 'testing' }
RSAttachPoint >> isInverted [
	^ inverted
]

{ #category : 'private' }
RSAttachPoint >> matrixFor: commonParents [
	| matrix |
	matrix := AthensAffineTransform new.
	commonParents reverseDo: [ :s | matrix multiplyBy: s matrix ].
	^ matrix
]

{ #category : 'private' }
RSAttachPoint >> positionFor: shape in: aLine [
	shape isPoint ifTrue: [ ^ shape ].
	^ self positionFor: shape in: aLine point: shape position
]

{ #category : 'private' }
RSAttachPoint >> positionFor: shape in: aLine point: pos [
	| commonParents |
	shape isPoint ifTrue: [ ^ shape ].
	(self hasParents: shape in: aLine) ifFalse: [ ^ pos ].
	shape parent = aLine parent ifTrue: [ ^ pos ].
	"TODO we can cache this info"
	commonParents := self commonParents: shape in: aLine.
	commonParents ifNil: [ ^ pos ].
	^ (self matrixFor: commonParents) transform: pos
]

{ #category : 'public - hooks' }
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

{ #category : 'public' }
RSAttachPoint >> straight [
	inverted := false
]
