"
I am the top class of shapes
"
Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'paint',
		'matrix',
		'path',
		'border',
		'announcer',
		'canvas',
		'isFixed'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #animation }
TSShape >> animation [ 
	^ self animation: TSTransitionAnimation new.
]

{ #category : #animation }
TSShape >> animation: animation [
	canvas animation: animation.
	^ animation
]

{ #category : #events }
TSShape >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent
]

{ #category : #events }
TSShape >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TSShape >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
TSShape >> border [
	^ border
]

{ #category : #accessing }
TSShape >> border: aBorder [
	border := aBorder
]

{ #category : #accessing }
TSShape >> canvas [
	^ canvas
]

{ #category : #accessing }
TSShape >> canvas: aCanvas [
	canvas := aCanvas 
]

{ #category : #accessing }
TSShape >> color [
	^ paint 
]

{ #category : #accessing }
TSShape >> color: aColor [
	paint := aColor
]

{ #category : #accessing }
TSShape >> encompassingRectangle [
	
]

{ #category : #accessing }
TSShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #testing }
TSShape >> hasEventCallback [
	"Return true if at least one event callback has been added to the shape"
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #accessing }
TSShape >> height [
	^ self extent y
]

{ #category : #testing }
TSShape >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #initialization }
TSShape >> initialize [
	super initialize.
	paint := Color lightGray.
	isFixed := false.
	self initializeMatrix
]

{ #category : #initialization }
TSShape >> initializeMatrix [
	matrix := AthensAffineTransform new
]

{ #category : #testing }
TSShape >> isFixed [ 
	^ isFixed
]

{ #category : #accessing }
TSShape >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #testing }
TSShape >> isInACanvas [
	^ canvas notNil
]

{ #category : #accessing }
TSShape >> matrix [
	^ matrix
]

{ #category : #accessing }
TSShape >> paint [
	^ paint
]

{ #category : #accessing }
TSShape >> paint: aPaint [
	paint := aPaint
]

{ #category : #accessing }
TSShape >> path [
	^ path
]

{ #category : #accessing }
TSShape >> path: aPath [
	path := aPath
]

{ #category : #accessing }
TSShape >> position [ 
	^ matrix x @ matrix y
]

{ #category : #accessing }
TSShape >> position: aPoint [
	matrix translation: aPoint
]

{ #category : #dependencies }
TSShape >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #actions }
TSShape >> remove [
	"Do nothing if the line is not already in a canvas"
	self isInACanvas ifFalse: [ ^ self ]. 
	canvas removeShape: self
]

{ #category : #actions }
TSShape >> resetPath [
	path := nil
]

{ #category : #transformations }
TSShape >> rotateByDegrees: angle [
	matrix rotateByDegrees: angle.
]

{ #category : #accessing }
TSShape >> scale [
	^ matrix scale
]

{ #category : #accessing }
TSShape >> scaleBy: scale [ 
	matrix scaleBy: scale.
]

{ #category : #actions }
TSShape >> signalUpdate [
	"Refresh the canvas"
	canvas ifNil: [ ^ self ].
	canvas signalUpdate
]

{ #category : #matrix }
TSShape >> translateBy: delta [
	matrix translateBy: delta.
	
]

{ #category : #accessing }
TSShape >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	self position: aPoint.
	
	"Need to do this in future work. Emit an event"
	"self triggerCallbacksForStep: (self position - oldPosition)"
]

{ #category : #events }
TSShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #accessing }
TSShape >> width [
	^ self extent x
]
