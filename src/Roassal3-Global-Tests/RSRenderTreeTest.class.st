Class {
	#name : #RSRenderTreeTest,
	#superclass : #RSTest,
	#instVars : [
		'tree'
	],
	#category : #'Roassal3-Global-Tests-Rendering'
}

{ #category : #accessing }
RSRenderTreeTest >> bigTree [
	^ self createTreeWith: 100
]

{ #category : #accessing }
RSRenderTreeTest >> createTreeWith: aNumber [
	| random |
	"do not modify this method"
	tree := self emptyTree.
	random := Random new.
	random seed: 777.

	1 to: aNumber do: [ :each | | box |
		box := RSBox new.
		box size: 10.
		box model: each.
		box popup.
		box position: (random next @ random next) * 1000.
		tree add: box.
	].

	^ tree
]

{ #category : #tests }
RSRenderTreeTest >> emptyTree [
	^ RSRTreeShapeCollection new
]

{ #category : #accessing }
RSRenderTreeTest >> leafs [
	^ tree root withAllChildren select: [ :node | node isLeaf ]
]

{ #category : #running }
RSRenderTreeTest >> setUp [
	super setUp.

	tree := self emptyTree
]

{ #category : #tests }
RSRenderTreeTest >> testAddNil [
	self should: [tree add: nil] raise: Error
]

{ #category : #tests }
RSRenderTreeTest >> testAllChildren [
	| list |
	list := tree root withAllChildren.
	self assert: list isEmpty.

	tree add: RSBox new.
	list := tree root withAllChildren.
	self assert: list size equals: 1.
	self assert: (list allSatisfy: [:each | each class = RSRNode ]) .

	tree add: (RSBox new position: 10@10).
	list := tree root withAllChildren.
	self assert: list size equals: 3
]

{ #category : #tests }
RSRenderTreeTest >> testBalanced [
	1 to: 10 do: [ :each | | box |
		box := RSBox new.
		box size: 10.
		box position: each * 10 asPoint.
		tree add: box. ].
	self assert: tree notEmpty.
	self assert: tree size equals: 10.
	self assert: tree isBalanced
]

{ #category : #tests }
RSRenderTreeTest >> testHeight [
	| b1 b2 b3 b4 |
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
	self assert: tree height equals: 3
]

{ #category : #tests }
RSRenderTreeTest >> testIsBalanced [
	| boxes |
	self assert: tree isBalanced.
	boxes := (1 to: 10) collect: [ :i | RSBox new size: 10. ].
	RSGridLayout on: boxes.
	self assert: (boxes allSatisfy: [:box |
		tree add: box.
		tree isBalanced ])
]

{ #category : #tests }
RSRenderTreeTest >> testOneElement [
	self assert: tree isEmpty.
	tree add: (RSBox new size: 10).
	self deny: tree isEmpty.
	self assert: tree root contents class equals: RSBox.
	self assert: tree size equals: 1
]

{ #category : #tests }
RSRenderTreeTest >> testOneElementContains [
	| result |
	tree add: (RSBox new size: 10).

	result := tree shapesAtPoint: 0@0.
	self assert: result notEmpty.
	result := tree shapesAtRectangle: (0@0 corner: 100@100).
	self assert: result notEmpty
]

{ #category : #tests }
RSRenderTreeTest >> testOneElementRectangle [
	| box |
	box := RSBox new size: 10.
	tree add: box.
	self assert: tree rectangle equals: box encompassingRectangle
]

{ #category : #tests }
RSRenderTreeTest >> testRemoveLeaf1 [
	| leafs size shapes shape |
	tree := self tree.

	size := tree size.
	leafs := self leafs.
	shapes := leafs collect: [ :each | each contents ] as: RSGroup.
	self assert: leafs notEmpty.
	self assert: tree isBalanced.
	shape := shapes shapeFromModel: 2.
	tree remove: shape.
	self assert: tree isBalanced.
	self assert: size - 1 equals: tree size.
	self assert: (tree shapesAtPoint: (shape position)) isEmpty.

	tree remove: (shapes shapeFromModel: 10).
	self assert: tree isBalanced.
	self assert: size - 2 equals: tree size
]

{ #category : #tests }
RSRenderTreeTest >> testRemoveLeaf2 [
	| leafs shapes shape size |
	tree := self tree.
	size := tree size.
	leafs := self leafs.
	shapes := leafs collect: [ :each | each contents ] as: RSGroup.
	"use the inspector to visualize the node position in the tree"
	shape := shapes shapeFromModel: 1.
	tree remove: shape.

	self assert: tree isBalanced.
	self assert: tree size + 1  equals: size
]

{ #category : #tests }
RSRenderTreeTest >> testRemoveLeaf3 [
	| leafs shapes random toRemove size |
	tree := self bigTree.
	size := tree size.
	leafs := self leafs.
	shapes := leafs collect: [ :each | each contents ] as: RSGroup.

	random := Random new.
	random seed: 444.
	shapes shuffleBy: random.
	toRemove := 1 to: (size / 2) asInteger do: [:index | | shape nodes heights newHeights |
		shape := shapes at: index.
		tree remove: shape.
		self assert: tree size + index equals: size.
		nodes := tree root withAllChildren.
		heights := nodes collect: [ :node | node height ].
		tree root computeHeight.
		newHeights := nodes collect: [ :node | node height ].
		heights with: newHeights do: [ :old :new |
			self assert: old equals: new. ].
		self assert: tree isBalanced.]
]

{ #category : #tests }
RSRenderTreeTest >> testRemoveRootChildren [
	| box |
	tree addAll: { box := RSBox new size: 10. }.
	tree remove: box.
	self assert: tree isEmpty
]

{ #category : #tests }
RSRenderTreeTest >> testRemoveZero [
	| value |
	value := false.
	tree remove: RSBox new ifAbsent: [ value := true ].
	self assert: value
]

{ #category : #tests }
RSRenderTreeTest >> testSearchPath1 [
	| path |
	tree := self emptyTree.
	path := tree root searchPath: (RSBox new).
	self assert: path isEmpty
]

{ #category : #tests }
RSRenderTreeTest >> testSearchPath2 [
	| path shape |
	tree := self emptyTree.
	tree add: (shape := RSBox new model: 1).
	path := tree root searchPath: shape.
	self assert: path asArray equals: { nil -> tree root }
]

{ #category : #tests }
RSRenderTreeTest >> testSearchPath3 [
	| nodes path shapes |
	tree := self tree.
	"tree inspect"
	nodes := self leafs.
	shapes := nodes collect: [ :node | node contents ] as: RSGroup.
	path := tree root searchPath: RSBox new.
	self assert: path isEmpty.
	path := tree root searchPath: (shapes shapeFromModel: 1).
	self assert: path asArray equals:
		{ nil-> tree root.
		false -> tree root left.
		false -> tree root left left }.
	path := tree root searchPath: (shapes shapeFromModel: 10).
	self assert: path asArray equals:
		{ nil-> tree root.
		true -> tree root right.
		false -> tree root right left.
		true -> tree root right left right.
		true -> tree root right left right right }
]

{ #category : #tests }
RSRenderTreeTest >> testSeriousBalance [
	| random canvas |
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
	]
]

{ #category : #tests }
RSRenderTreeTest >> testThreeElements [
	| b1 b2 b3 |
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	b3 := RSBox new size: 10; position: -10@ -10.
	tree addAll: { b1. b2. b3 }.
	self assert: tree notEmpty.
	self assert: tree size equals: 3.
	self assert: tree root contents equals: nil.
	self assert: tree root left notNil.
	self assert: tree root right notNil
]

{ #category : #tests }
RSRenderTreeTest >> testThreeElementsContains [
	| b1 b2 b3 result |
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
	self assert: result size equals: 3
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElements [
	| b1 b2 |
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	tree addAll: { b1. b2 }.
	self assert: tree notEmpty.
	self assert: tree size equals: 2.
	self assert: tree root contents equals: nil.
	self assert: tree root left notNil.
	self assert: tree root right notNil
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElementsContains [
	| b1 b2 result |
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
	self assert: result size equals: 2
]

{ #category : #tests }
RSRenderTreeTest >> testTwoElementsRectangle [
	| b1 b2 group |
	b1 := RSBox new size: 10.
	b2 := RSBox new size: 30; position: 30@30.
	group := RSGroup new.
	group addAll: { b1. b2 }.
	tree addAll: group.
	self assert: tree rectangle equals: group encompassingRectangle
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElement [
	self assert: tree isEmpty.
	self assert: tree root isNilNode.
	self assert: tree size equals: 0
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElementContains [
	| result |
	result := tree shapesAtPoint: 0@0.
	self assert: result isEmpty.
	result := tree shapesAtRectangle: (0@0 corner: 100@100).
	self assert: result isEmpty
]

{ #category : #tests }
RSRenderTreeTest >> testZeroElementRectangle [
	self assert: tree rectangle equals: (0@0 corner: 0@0)
]

{ #category : #accessing }
RSRenderTreeTest >> tree [
	^ self createTreeWith: 10
]
