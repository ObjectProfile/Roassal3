Class {
	#name : #RSRenderTreeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Rendering'
}

{ #category : #tests }
RSRenderTreeTest >> testBalanced [
	| tree |
	tree := RSRTreeShapeCollection new.
	1 to: 10 do: [ :each | | box |
		box := RSBox new.
		box size: 10.
		box position: each * 10 asPoint.
		tree add: box. ].
	self assert: tree notEmpty.
	self assert: tree size equals: 10.
	self assert: tree isBalanced.
	
]

{ #category : #tests }
RSRenderTreeTest >> testHeight [
	| tree b1 b2 b3 b4 |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	b3 := RSBox new size: 10; position: -10@ -10.
	b4 := RSBox new size: 10; position: 50@50.
	self assert: tree height equals: 0.
	tree add: b1.
	self assert: tree height equals: 1.
	tree add: b2.
	self assert: tree height equals: 2.
	tree add: b3.
	self assert: tree height equals: 3.
	tree add: b4.
	self assert: tree height equals: 3.
]

{ #category : #tests }
RSRenderTreeTest >> testIsBalanced [
	| tree boxes |
	tree := RSRTreeShapeCollection new.
	self assert: tree isBalanced.
	boxes := (1 to: 10) collect: [ :i | RSBox new size: 10. ].
	RSGridLayout on: boxes.
	boxes do: [ :box | 
		tree add: box.
		self assert: tree isBalanced ].
]

{ #category : #tests }
RSRenderTreeTest >> testOneElement [
	| tree |
	tree := RSRTreeShapeCollection new.
	self assert: tree isEmpty.
	tree add: (RSBox new size: 10).
	self deny: tree isEmpty.
	self assert: tree root contents class equals: RSBox.
	self assert: tree size equals: 1.
]

{ #category : #tests }
RSRenderTreeTest >> testOneElementContains [
	| tree result |
	tree := RSRTreeShapeCollection new.
	tree add: (RSBox new size: 10).

	result := tree shapesAtPoint: 0@0.
	self assert: result notEmpty.
	result := tree shapesAtRectangle: (0@0 corner: 100@100).
	self assert: result notEmpty.
]

{ #category : #tests }
RSRenderTreeTest >> testOneElementRectangle [
	| tree box |
	tree := RSRTreeShapeCollection new.
	box := RSBox new size: 10.
	tree add: box.
	self assert: tree rectangle equals: box encompassingRectangle.
]

{ #category : #tests }
RSRenderTreeTest >> testOneElementRemove [
	| tree box |
	tree := RSRTreeShapeCollection new.
	box := RSBox new size: 10.
	tree add: box.
	self assert: tree notEmpty.
	tree remove: box.
	self assert: tree isEmpty.
	
]

{ #category : #tests }
RSRenderTreeTest >> testSeriousBalance [
	| tree random canvas |
	tree := RSRTreeShapeCollection new.
	random := Random new.
	random seed: 777.
	canvas := RSCanvas new.
	1 to: 100 do: [ :each | | box |
		box := RSBox new.
		box size: 10.
		box model: each.
		box popup.
		box position: (random next @ random next) * 1000.
		canvas add: box.
		
		tree add: box.
		self assert: tree height equals: tree root computeHeight.
		self assert: tree isTotalBalanced.		
	].
	canvas @ RSCanvasController.
	
]

{ #category : #tests }
RSRenderTreeTest >> testThreeElements [
	| tree b1 b2 b3 |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	b3 := RSBox new size: 10; position: -10@ -10.
	tree addAll: { b1. b2. b3 }.
	self assert: tree notEmpty.
	self assert: tree size equals: 3.
	self assert: tree root contents equals: nil.
	self assert: tree root left notNil.
	self assert: tree root right notNil.
]

{ #category : #tests }
RSRenderTreeTest >> testThreeElementsContains [
	| tree b1 b2 b3 result |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	b3 := RSBox new size: 10; position: -10@ -10.
	tree addAll: { b1. b2. b3 }.
	
	result := tree shapesAtPoint: 0@0.
	self assert: result first equals: b1.
	
	result := tree shapesAtPoint: 30@30.
	self assert: result first equals: b2.
	
	result := tree shapesAtPoint: -10@ -10.
	self assert: result first equals: b3.
	
	result := tree shapesAtRectangle: (0@0 corner: 10@10).
	self assert: result first equals: b1.
	
	result := tree shapesAtRectangle: (0@0 corner: 30@30).
	self assert: result size equals: 2.
	
	result := tree shapesAtRectangle: (-20@ -20 corner: 30@30).
	self assert: result size equals: 3.
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElements [
	| tree b1 b2 |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	tree addAll: { b1. b2 }.
	self assert: tree notEmpty.
	self assert: tree size equals: 2.
	self assert: tree root contents equals: nil.
	self assert: tree root left notNil.
	self assert: tree root right notNil.
	
	
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElementsContains [
	| tree b1 b2 result |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	tree addAll: { b1. b2 }.
	result := tree shapesAtPoint: 0@0.
	self assert: result first equals: b1.
	
	result := tree shapesAtPoint: 30@30.
	self assert: result first equals: b2.
	
	result := tree shapesAtRectangle: (0@0 corner: 10@10).
	self assert: result first equals: b1.
	
	result := tree shapesAtRectangle: (0@0 corner: 30@30).
	self assert: result size equals: 2.
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElementsRectangle [
	| tree b1 b2 group|
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	group := RSGroup new.
	group addAll: { b1. b2 }.
	tree addAll: group.
	self assert: tree rectangle equals: group encompassingRectangle.
	
	
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElementsRemove [
	| tree b1 b2 |
	tree := RSRTreeShapeCollection new.
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	tree addAll: { b1. b2 }.
	tree remove: b1.
	self assert: tree size equals: 1.
	tree remove: b2.
	self assert: tree size equals: 0.
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElement [
	| tree |
	tree := RSRTreeShapeCollection new.
	self assert: tree isEmpty.
	self assert: tree root isNilNode.
	self assert: tree size equals: 0
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElementContains [
	| tree result |
	tree := RSRTreeShapeCollection new.
	result := tree shapesAtPoint: 0@0.
	self assert: result isEmpty.
	result := tree shapesAtRectangle: (0@0 corner: 100@100).
	self assert: result isEmpty
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElementRectangle [
	| tree box |
	tree := RSRTreeShapeCollection new.
	self assert: tree rectangle equals: (0@0 corner: 0@0)
]
