"
TODO
"
Class {
	#name : #RSPolyline,
	#superclass : #RSAbstractControlPointsLine,
	#instVars : [
		'radius'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #visiting }
RSPolyline >> buildPathOn: visitor [
	visitor buildPolylinePath: self
]

{ #category : #accessing }
RSPolyline >> cornerRadii [
	^ radius ifNil: [ 0 ].
]

{ #category : #accessing }
RSPolyline >> cornerRadii: aNumber [
	radius := aNumber abs
]

{ #category : #testing }
RSPolyline >> includesPoint: aPoint [
	"Answer whether any segment of this polyline includes aPoint."

	self hasBorder ifFalse: [ ^ false ].
	self controlPoints overlappingPairsDo: [ :a :b | 
		(aPoint onLineFrom: a to: b within: self includedRadius)
			ifTrue: [ ^ true ] ].
	^ false
]
