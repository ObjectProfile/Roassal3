"
I am a specific kind of force based layout that has an enclosing rectangle for elements. On each step, I apply a repulsion force to elements that are close to the enclosing rectangle.

"
Class {
	#name : #RSRectangleForceLayout,
	#superclass : #RSForceBasedLayout,
	#instVars : [
		'enclosingRectangle',
		'enclosingThreshold',
		'enclosingForce'
	],
	#category : #'Roassal3-Layouts-Force'
}

{ #category : #accessing }
RSRectangleForceLayout >> enclosingForce [
	^ enclosingForce
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingForce: aNumber [
	"Establishes the force that is applied to the elements when they are close enough to the enclosing rectangle."

	enclosingForce := aNumber
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingRectangle [
	^ enclosingRectangle
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingRectangle: aRectangleInCanvasSpaceCoordinates [
	"Establishes the rectangle to enclose the elements."

	enclosingRectangle := aRectangleInCanvasSpaceCoordinates
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingThreshold [
	^ enclosingThreshold
]

{ #category : #accessing }
RSRectangleForceLayout >> enclosingThreshold: aNumber [
	"Establishes the distance from the enclosing rectangle where the repulsion force applies to elements."

	enclosingThreshold := aNumber
]

{ #category : #initialization }
RSRectangleForceLayout >> initialize [
	super initialize.

	enclosingThreshold := 50.
	enclosingForce := 0.3.
	enclosingRectangle := Rectangle floatCenter: 0@0 extent: 500@500.
]

{ #category : #events }
RSRectangleForceLayout >> step [
	self stepRectangleForces.
	super step
]

{ #category : #events }
RSRectangleForceLayout >> stepRectangleForces [
	"Apply a repulsion force to elements that are close to the enclosing rectangle."

	| k |
	k := enclosingForce * alpha.
	(k closeTo: 0) ifTrue: [ ^ self ].

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
		]
]
