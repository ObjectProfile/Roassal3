Class {
	#name : #TSPopupTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'elements'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
TSPopupTest >> setUp [
	super setUp.
	view := RSView new.
	elements := RSShapeBuilder box elementsOn: #(1 2).
	view addAll: elements
]

{ #category : #tests }
TSPopupTest >> testNoPopup [
	elements first announce: TSMouseEnter.
	self assert: view numberOfShapes equals: elements size.
]

{ #category : #tests }
TSPopupTest >> testPopupOnElementNotAddedToAView [
	| el |
	el := RSShapeBuilder box element.
	el @ TSPopup.
	el announce: TSMouseEnter.
	"Should not produce an error"
]

{ #category : #tests }
TSPopupTest >> testWithPopup [
	elements @ TSPopup.
	self assert: view fixedShapes size equals: 0 .
	
	elements first announce: TSMouseMove.
	self assert: view numberOfShapes equals: elements size.
	self assert: view fixedShapes size equals: 1.
]
