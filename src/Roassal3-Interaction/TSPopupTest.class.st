Class {
	#name : #TSPopupTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
TSPopupTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := #(1 2) collect: [ :m | TSBox new model: m; yourself ] as: RSGroup.
	canvas addAll: shapes
]

{ #category : #tests }
TSPopupTest >> testNoPopup [
	shapes first announce: RSMouseEnter.
	self assert: canvas numberOfShapes equals: shapes size.
]

{ #category : #tests }
TSPopupTest >> testPopupOnElementNotAddedToAView [
	| el |
	el := RSShapeBuilder box element.
	el @ TSPopup.
	el announce: RSMouseEnter.
	"Should not produce an error"
]

{ #category : #tests }
TSPopupTest >> testWithPopup [
	shapes @ TSPopup.
	self assert: canvas fixedShapes size equals: 0 .
	
	shapes first announce: RSMouseMove.
	self assert: canvas numberOfShapes equals: shapes size.
	self assert: canvas fixedShapes size equals: 1.
]
