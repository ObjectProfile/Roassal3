"
The `RSAbstractVerticalTreeLayout` class is an abstract base class that provides common functionality for vertical tree layout algorithms in Roassal. Vertical tree layouts arrange nodes in a tree-like structure where each level of the tree is aligned horizontally.

Instances of `RSAbstractVerticalTreeLayout` can be used with `RSVerticalTree`
"
Class {
	#name : #RSAbstractVerticalTreeLayout,
	#superclass : #RSAbstractRegularTreeLayout,
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #testing }
RSAbstractVerticalTreeLayout class >> isAbstract [
	^ self = RSAbstractVerticalTreeLayout
]

{ #category : #initialization }
RSAbstractVerticalTreeLayout >> initialize [
	super initialize.
	verticalGap := 20.
	horizontalGap := 3
]

{ #category : #'private - hook' }
RSAbstractVerticalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each |
		| children |
		
		childrenPosition := y + each height + self verticalGap.
		children := self computeChildrenFor: each.
			
		treeSize := self
			layout: children
			atPoint: x @ childrenPosition
			atLayer: aNumber + 1.
		treeSize < each width ifTrue: [
			self translate: children by: (each width - treeSize) / 2.0 @ 0.
			treeSize := each width. ].
		middleOfTree := x + (treeSize / 2.0) - (each width / 2.0).
		translator translateTopLeftOf: each to: middleOfTree @ y.
		x := x + treeSize + self horizontalGap.
		self step ].
	^ x - aPoint x - self horizontalGap
]

{ #category : #private }
RSAbstractVerticalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self topGap.
	nodesByLayer do: [:eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [ :max :eachNode |
			translator translateTopLeftOf: eachNode to: (eachNode position x @ cursor).
			max max: eachNode height ].
		cursor := cursor + layerDepthSize + self verticalGap ]
]

{ #category : #'private - hook' }
RSAbstractVerticalTreeLayout >> translate: aNodeCollection by: delta [
	aNodeCollection ifEmpty: [ ^ self ].
	aNodeCollection do: [ :each |
		each translateBy: delta.
		self translate: (self childrenFor: each) by: delta]
]
