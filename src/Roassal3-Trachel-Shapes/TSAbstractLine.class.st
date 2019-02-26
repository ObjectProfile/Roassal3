"
I represent the abstract lines that have start and end points
"
Class {
	#name : #TSAbstractLine,
	#superclass : #TSShape,
	#instVars : [
		'startPoint',
		'endPoint'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #visiting }
TSAbstractLine >> accept: visitor [
	visitor visitLine: self.
]

{ #category : #'style-cap' }
TSAbstractLine >> capButt [
	self border capButt
]

{ #category : #'style-cap' }
TSAbstractLine >> capRound [
	self border capRound
]

{ #category : #'style-cap' }
TSAbstractLine >> capSquare [
	self border capSquare
]

{ #category : #accessing }
TSAbstractLine >> color: aColor [
	self strokePaint: aColor
]

{ #category : #'style-dashes' }
TSAbstractLine >> dashArray: arrayOfNumbers [
	self border dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
TSAbstractLine >> endPoint [
	^ endPoint
]

{ #category : #accessing }
TSAbstractLine >> endPoint: point [
	endPoint := point.
	self resetPath
]

{ #category : #initialization }
TSAbstractLine >> initialize [ 
	super initialize.
	paint := nil.
	border := TSBorder new.
	startPoint := 0@0.
	endPoint := 100@100.
	
]

{ #category : #'style-join' }
TSAbstractLine >> joinBevel [
	self border joinBevel
]

{ #category : #'style-join' }
TSAbstractLine >> joinMiter [
	self border joinMiter
]

{ #category : #'style-join' }
TSAbstractLine >> joinRound [
	self border joinRound
]

{ #category : #accessing }
TSAbstractLine >> startPoint [ 
	^ startPoint 
]

{ #category : #accessing }
TSAbstractLine >> startPoint: point [
	startPoint := point.
	self resetPath
]

{ #category : #accessing }
TSAbstractLine >> strokeColor: aColor [
	self strokePaint: aColor
]

{ #category : #accessing }
TSAbstractLine >> strokePaint: aPaint [
	self border paint: aPaint.
]

{ #category : #accessing }
TSAbstractLine >> width: aNumber [
	self border width: aNumber.
]
