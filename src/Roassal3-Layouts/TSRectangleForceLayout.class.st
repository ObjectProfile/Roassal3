"
I am a specific kind of force based layout that has an enclosing rectangle for elements. On each step, I apply a repulsion force to elements that are close to the enclosing rectangle.

"
Class {
	#name : #TSRectangleForceLayout,
	#superclass : #TSForceBasedLayout,
	#instVars : [
		'enclosingRectangle',
		'enclosingThreshold',
		'enclosingForce'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
TSRectangleForceLayout >> enclosingForce [
	^ enclosingForce
]

{ #category : #accessing }
TSRectangleForceLayout >> enclosingForce: anObject [
	enclosingForce := anObject
]

{ #category : #accessing }
TSRectangleForceLayout >> enclosingRectangle [
	^ enclosingRectangle
]

{ #category : #accessing }
TSRectangleForceLayout >> enclosingRectangle: aRectangleInCanvasSpaceCoordinates [
	enclosingRectangle := aRectangleInCanvasSpaceCoordinates
]

{ #category : #accessing }
TSRectangleForceLayout >> enclosingThreshold [
	^ enclosingThreshold
]

{ #category : #accessing }
TSRectangleForceLayout >> enclosingThreshold: anObject [
	enclosingThreshold := anObject
]

{ #category : #events }
TSRectangleForceLayout >> initialize [
	super initialize.

	enclosingThreshold := 50.
	enclosingForce := 0.3.

]

{ #category : #events }
TSRectangleForceLayout >> step [
	self stepRectangleForces.
	super step.

]

{ #category : #events }
TSRectangleForceLayout >> stepRectangleForces [
	"Apply a repulsion force to elements that are close to the enclosing rectangle."

	| k |
	k := enclosingForce * alpha.
	(k closeTo: 0) ifTrue: [ ^self ].
	
	nodes do: [ :each |
		| eachRect diff |
		eachRect := each encompassingRectangle.

		"horizontal"
		(diff := eachRect left - enclosingRectangle left) < enclosingThreshold ifTrue: [ 
			each translateTo: each position + (k * (enclosingThreshold - diff)@0) ].

		(diff := enclosingRectangle right - eachRect right) < enclosingThreshold ifTrue: [ 
			each translateTo: each position - (k * (enclosingThreshold - diff)@0) ].

		"vertical"
		(diff := eachRect top - enclosingRectangle top) < enclosingThreshold ifTrue: [ 
			each translateTo: each position + (0@(k * (enclosingThreshold - diff))) ].

		(diff := enclosingRectangle bottom - eachRect bottom) < enclosingThreshold ifTrue: [ 
			each translateTo: each position - (0@(k * (enclosingThreshold - diff))) ].
		].

]
