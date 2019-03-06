"
A TSGroup represents collections of Roassal elements. A RTGroup is not designed to contain other things than Roassal elements. 
A TSGroup is polymorphic to RSElement. When an RSElement is expected, one can provide an RTGroup.
"
Class {
	#name : #TSGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'isFixed',
		'matrix'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSGroup >> accept: visitor [
	visitor visitGroup: self.
]

{ #category : #adding }
TSGroup >> addedIn: canvas [
	self isFixed
		ifTrue: [ canvas addFixedShape: self ]
		ifFalse: [ canvas addBasicShape: self ].
]

{ #category : #accessing }
TSGroup >> encompassingRectangle [
	^ self
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #accessing }
TSGroup >> extent [
	^ self encompassingRectangle extent
]

{ #category : #testing }
TSGroup >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #accessing }
TSGroup >> isFixed [ 
	^ isFixed ifNil: [ isFixed := false ].
]

{ #category : #accessing }
TSGroup >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #matrix }
TSGroup >> matrix [
	^ matrix ifNil: [ matrix := AthensAffineTransform new ].
]

{ #category : #matrix }
TSGroup >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : #matrix }
TSGroup >> position [ 
	^ self matrix translation
]

{ #category : #matrix }
TSGroup >> position: aPoint [
	self matrix translation: aPoint
]
