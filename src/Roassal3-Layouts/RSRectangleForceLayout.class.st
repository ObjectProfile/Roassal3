"
I am a specific kind of force based layout that has an enclosing rectangle for elements. On each step, I apply a repulsion force to elements that are close to the enclosing rectangle.

"
Class {
	#name : #RSRectangleForceLayout,
	#superclass : #RSOptimizedForceBasedLayout,
	#instVars : [
		'enclosingRectangle',
		'enclosingThreshold',
		'enclosingForce'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSRectangleForceLayout >> enclosingForce [
	^ enclosingForce
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingForce: anObject [
	enclosingForce := anObject
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingRectangle [
	^ enclosingRectangle
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingRectangle: aRectangleInCanvasSpaceCoordinates [
	enclosingRectangle := aRectangleInCanvasSpaceCoordinates
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingThreshold [
	^ enclosingThreshold
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingThreshold: anObject [
	enclosingThreshold := anObject
]

{ #category : #events }
RSRectangleForceLayout >> initialize [
	super initialize.

	enclosingThreshold := 50.
	enclosingForce := 0.3.

]

{ #category : #events }
RSRectangleForceLayout >> step [
	self stepRectangleForces.
	super step.

]

{ #category : #events }
RSRectangleForceLayout >> stepRectangleForces [
	"Apply a repulsion force to elements that are close to the enclosing rectangle."

	nodes do: [ :each |
		| eachRect diff |
		eachRect := each encompassingRectangle.

		"horizontal"
		(diff := eachRect left - enclosingRectangle left) < enclosingThreshold ifTrue: [ 
			each translateTo: each position + (enclosingForce * (enclosingThreshold - diff)@0) ].

		(diff := enclosingRectangle right - eachRect right) < enclosingThreshold ifTrue: [ 
			each translateTo: each position - (enclosingForce * (enclosingThreshold - diff)@0) ].

		"vertical"
		(diff := eachRect top - enclosingRectangle top) < enclosingThreshold ifTrue: [ 
			each translateTo: each position + (0@(enclosingForce * (enclosingThreshold - diff))) ].

		(diff := enclosingRectangle bottom - eachRect bottom) < enclosingThreshold ifTrue: [ 
			each translateTo: each position - (0@(enclosingForce * (enclosingThreshold - diff))) ].

		].


]
