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
	| cp |
	cp := self controlPoints.
	1 to: cp size - 1 do: [ :i | | p2 p1|
		p1 := cp at: i.
		p2 := cp at: i + 1.
		(aPoint onLineFrom: p1 to: p2 within: RSLine delta) ifTrue: [ ^ true ] ].
	^ false.
]
