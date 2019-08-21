Class {
	#name : #RSPopupTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'elements'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
RSPopupTest >> setUp [
	super setUp.
	view := RSView new.
	elements := RSShapeBuilder box elementsOn: #(1 2).
	view addAll: elements
]

{ #category : #tests }
RSPopupTest >> testNoPopup [
	elements first announce: TSMouseEnter.
	self assert: view numberOfShapes equals: elements size.
]

{ #category : #tests }
RSPopupTest >> testPopupOnElementNotAddedToAView [
	| el |
	el := RSShapeBuilder box element.
	el @ RSPopup.
	el announce: TSMouseEnter.
	"Should not produce an error"
]

{ #category : #tests }
RSPopupTest >> testWithPopup [
	elements @ RSPopup.
	self assert: view fixedShapes size equals: 0 .
	
	elements first announce: TSMouseMove.
	self assert: view numberOfShapes equals: elements size.
	self assert: view fixedShapes size equals: 1.
]
