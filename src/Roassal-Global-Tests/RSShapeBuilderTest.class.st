Class {
	#name : 'RSShapeBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'b'
	],
	#category : 'Roassal-Global-Tests-Mondrian',
	#package : 'Roassal-Global-Tests',
	#tag : 'Mondrian'
}

{ #category : 'running' }
RSShapeBuilderTest >> setUp [
	super setUp.
	b := RSShapeBuilder new
]

{ #category : 'tests' }
RSShapeBuilderTest >> testBox [

	| result |
	b box.
	result := b shapesOn: #(1 2).
	self assert: result class equals: RSGroup.
	self assert: result size equals: 2.
	self assert: (result allSatisfy: [ :s | s class == RSBox ]).
	self assert: (result collect: #model) asArray equals: #(1 2)
]

{ #category : 'tests' }
RSShapeBuilderTest >> testCircle [

	| result |
	b circle.
	result := b shapesOn: #(1 2).
	self assert: result class equals: RSGroup.
	self assert: result size equals: 2.
	self assert: (result allSatisfy: [ :s | s class == RSEllipse ]).
	self assert: (result collect: #model) asArray equals: #(1 2)
]

{ #category : 'tests' }
RSShapeBuilderTest >> testLabel [

	| result |
	b label.
	result := b shapesOn: #(1 2).
	self assert: result class equals: RSGroup.
	self assert: result size equals: 2.
	self assert: (result allSatisfy: [ :s | s class == RSLabel ]).
	self assert: (result collect: #model) asArray equals: #(1 2)
]

{ #category : 'tests' }
RSShapeBuilderTest >> testLabel2 [

	| result |
	b label.
	self assert: b width isNil.
	self assert: b height isNil.

	result := b shapesOn: #(1 20000).

	self assert: b width isNil.
	self assert: b height isNil.

	self assert: result class equals: RSGroup.
	self assert: result size equals: 2.
	self assert: (result allSatisfy: [ :s | s class == RSLabel ]).
	self assert: (result collect: #model) asArray equals: #(1 20000).

	self assert: result first width < result second width
]

{ #category : 'tests' }
RSShapeBuilderTest >> testLabeled [

	| shape |
	b box.
	self deny: b doesUseLabel.
	shape := b shapeOn: #(1).
	self assert: shape class equals: RSBox.

	b labeled.
	self assert: b doesUseLabel.
	b box.
	shape := b shapeOn: #(1).
	self assert: shape class equals: RSComposite.
	self assert: shape children size equals: 2.
	self assert: shape children second class equals: RSLabel.
	self assert: shape children first class equals: RSBox
]

{ #category : 'tests' }
RSShapeBuilderTest >> testLabeled02 [

	| shape lbl |
	b box.
	b labeled: 42.
	shape := b shapeOn: #(1).
	self assert: shape class equals: RSComposite.
	self assert: shape children size equals: 2.

	lbl := shape children second.
	self assert: lbl class equals: RSLabel.
	self assert: lbl text equals: '42'.

	self assert: shape children first class equals: RSBox
]

{ #category : 'tests' }
RSShapeBuilderTest >> testLabeled03 [

	| shape lbl |
	b box.
	b labeled: #squared.
	shape := b shapeOn: 3.
	self assert: shape class equals: RSComposite.
	self assert: shape children size equals: 2.

	lbl := shape children second.
	self assert: lbl class equals: RSLabel.
	self assert: lbl text equals: '9'.

	self assert: shape children first class equals: RSBox
]

{ #category : 'tests' }
RSShapeBuilderTest >> testWithBorder [

	| result shape |
	self assert: b borderColor isNil.
	self assert: b borderWidth isNil.

	b circle withBorder.
	self assert: b borderColor equals: Color black.
	self assert: b borderWidth equals: 3.

	result := b shapesOn: #(1).

	self assert: b borderColor equals: Color black.
	self assert: b borderWidth equals: 3.

	self assert: result class equals: RSGroup.
	self assert: result size equals: 1.

	self assert: (result allSatisfy: [ :s | s class == RSEllipse ]).
	self assert: (result collect: #model) asArray equals: #(1).

	shape := result first.
	self assert: shape border isNotNil
]
