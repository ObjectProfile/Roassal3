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
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSAbstractLine >> accept: visitor [
	visitor visitLine: self.
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
	self border width: 2.
]
