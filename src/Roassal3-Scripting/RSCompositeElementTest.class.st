"
I have tests for TSGroup asElement
"
Class {
	#name : #RSCompositeElementTest,
	#superclass : #TSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #running }
RSCompositeElementTest >> setUp [
	view := RSView new
]

{ #category : #tests }
RSCompositeElementTest >> testAddOnceInCanvas [
	| elements |
	elements := RSShapeBuilder box 
		elementsOn: (1 to: 10).
	view addAll: elements.
	self assert: view elements size equals: 10.
	view := RSView new.
	view add: elements asElement.
	self assert: view elements size equals: 1.
]

{ #category : #tests }
RSCompositeElementTest >> testAsElement [
	| elements |
	elements := RSShapeBuilder box 
		elementsOn: (1 to: 10).
	view add: elements asElement.
	self assert: view elements size equals: 1.
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
