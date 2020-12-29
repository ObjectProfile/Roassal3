"
`RSPolyline` represents a line joining a number of points

```
c := RSCanvas new.

polyline := RSPolyline new.
polyline controlPoints: { 0@0 . 20@30 . 100@40 }.
c add: polyline.

c open
```
"
Class {
	#name : #RSPolyline,
	#superclass : #RSAbstractControlPointsLine,
	#instVars : [
		'radius'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #testing }
RSPolyline >> basicIncludesPoint: aPoint [
	"Answer whether any segment of this polyline includes aPoint."
	self controlPoints overlappingPairsDo: [ :a :b | 
		(aPoint onLineFrom: a to: b within: self includedRadius)
			ifTrue: [ ^ true ] ].
	^ false
]

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
	radius := aNumber abs.
	self resetPath.
]
