"
TODO
"
Class {
	#name : #TSPolyline,
	#superclass : #TSAbstractControlPointsLine,
	#instVars : [
		'radius'
	],
	#category : #'Roassal3-Shape'
}

{ #category : #visiting }
TSPolyline >> buildPathOn: visitor [
	visitor buildPolylinePath: self
]

{ #category : #accessing }
TSPolyline >> cornerRadii [
	^ radius ifNil: [ 0 ].
]

{ #category : #accessing }
TSPolyline >> cornerRadii: aNumber [
	radius := aNumber abs
]

{ #category : #testing }
TSPolyline >> includesPoint: aPoint [
	| cp |
	cp := controlPoints.
	1 to: cp size - 1 do: [ :i | | p2 p1|
		p1 := cp at: i.
		p2 := cp at: i + 1.
		(aPoint onLineFrom: p1 to: p2 within: TSLine delta) ifTrue: [ ^ true ] ].
	^ false.
]
