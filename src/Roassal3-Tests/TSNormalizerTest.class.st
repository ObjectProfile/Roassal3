"
I am test for RSNormalizer
"
Class {
	#name : #TSNormalizerTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Utils'
}

{ #category : #tests }
TSNormalizerTest >> testBasic [ 
	| elements |
	elements := RSShapeBuilder box
		elementsOn: #(1 2).
	
	self assert: elements size equals: 2.
	self assert: elements first color equals: Color gray.
	RSNormalizer color
		elements: elements;
		normalize: #yourself.
	self assert: elements first color equals: Color green.
	RSNormalizer size
		elements: elements;
		from: 100;
		to: 200;
		normalize: #yourself.
	self assert: elements first extent equals: 100@100.
	self assert: elements first extent equals: 100@100.
]
