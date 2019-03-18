"
I have tests for TSGroup asElement
"
Class {
	#name : #RSGroupElementTest,
	#superclass : #TSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #running }
RSGroupElementTest >> setUp [
	view := RSView new
]

{ #category : #tests }
RSGroupElementTest >> testAsElement [
	| elements |
	elements := RSShapeBuilder box 
		elementsOn: (1 to: 10).
	view add: elements asElement.
	self assert: view elements size equals: 1.
]
