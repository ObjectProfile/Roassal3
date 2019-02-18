"
I am the top class of shapes
"
Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'color',
		'matrix',
		'path',
		'border',
		'announcer'
	],
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #events }
TSShape >> announce: anEvent [
	self announcer announce: anEvent
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
TSShape >> color [
	^ color 
]

{ #category : #accessing }
TSShape >> color: aColor [
	color := aColor
]

{ #category : #accessing }
TSShape >> encompassingRectangle [
	
]

{ #category : #testing }
TSShape >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #initialization }
TSShape >> initialize [
	super initialize.
	color := Color lightGray.
	matrix := AthensAffineTransform new.
	
]

{ #category : #accessing }
TSShape >> matrix [
	^ matrix
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

{ #category : #initialization }
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

{ #category : #transformations }
TSShape >> scaleBy: anInteger [
	matrix scaleBy: anInteger
]

{ #category : #events }
TSShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
