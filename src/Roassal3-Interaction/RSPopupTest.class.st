Class {
	#name : #RSPopupTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
RSPopupTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := #(1 2) collect: [ :m | RSBox new model: m; yourself ] as: RSGroup.
	canvas addAll: shapes
]

{ #category : #tests }
RSPopupTest >> testNoPopup [
	shapes first announce: RSMouseEnter.
	self assert: canvas numberOfShapes equals: shapes size.
]

{ #category : #tests }
RSPopupTest >> testPopupOnElementNotAddedToAView [
	| el |
	el := RSShapeBuilder box element.
	el @ RSPopup.
	el announce: RSMouseEnter.
	"Should not produce an error"
]

{ #category : #tests }
RSPopupTest >> testWithPopup [
	shapes @ RSPopup.
	self assert: canvas fixedShapes size equals: 0 .
	
	shapes first announce: RSMouseMove.
	self assert: canvas numberOfShapes equals: shapes size.
	self assert: canvas fixedShapes size equals: 1.
]
