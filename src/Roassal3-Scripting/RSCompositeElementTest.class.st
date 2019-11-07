"
I have tests for TSGroup asElement
"
Class {
	#name : #RSCompositeElementTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #running }
RSCompositeElementTest >> setUp [
	canvas := RSCanvas new
]

{ #category : #tests }
RSCompositeElementTest >> testCreateComposite [
	| elements |
	elements := RSShapeBuilder composite
		shapes: [ :m | 
			RSShapeBuilder box
				size: m;
				elementsOn: (1 to: m).
			];
		elementsOn: (1 to: 10).
	self assert: elements size equals: 10.
	self assert: elements first shapes size equals: 1.
	self assert: elements last shapes size equals: 10.
	
	self assert: elements first encompassingRectangle extent equals: 1@1.
	self assert: elements last encompassingRectangle extent equals: 10@10.
]
