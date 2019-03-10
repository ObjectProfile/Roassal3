"
I am the top class of shapes
"
Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'paint',
		'path',
		'border',
		'announcer',
		'canvas',
		'isFixed'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #adding }
TSShape >> addedIn: aCanvas [
	self isFixed
		ifTrue: [ aCanvas addFixedShape: self ]
		ifFalse: [ aCanvas addBasicShape: self ].
	canvas := aCanvas.
]

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
	announcer announce: anEvent value.
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

{ #category : #border }
TSShape >> border [
	^ border
]

{ #category : #border }
TSShape >> border: aBorder [
	border := aBorder
]

{ #category : #border }
TSShape >> borderDo: aBlock [
	border ifNil: [ border := TSBorder new ].
	aBlock value: border
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
	self subclassResponsibility
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

{ #category : #actions }
TSShape >> loadShape: aShape [
	self subclassResponsibility
]

{ #category : #accessing }
TSShape >> paint [
	^ paint
]

{ #category : #accessing }
TSShape >> paint: aPaint [
	paint := aPaint
]

{ #category : #path }
TSShape >> path [
	^ path
]

{ #category : #path }
TSShape >> path: aPath [
	path := aPath
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

{ #category : #path }
TSShape >> resetPath [
	path := nil
]

{ #category : #actions }
TSShape >> signalUpdate [
	"Refresh the canvas"
	canvas ifNil: [ ^ self ].
	canvas signalUpdate
]

{ #category : #events }
TSShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #accessing }
TSShape >> width [
	^ self extent x
]
