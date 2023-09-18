"
The `RSAbstractHorizontalTreeLayout` class is an abstract base class that provides common functionality for horizontal tree layout algorithms in Roassal. Horizontal tree layouts arrange nodes in a tree-like structure where each level of the tree is aligned vertically.

Instances of `RSAbstractHorizontalTreeLayout` can be used with `RSHorizontalTreeLayout`
"
Class {
	#name : #RSAbstractHorizontalTreeLayout,
	#superclass : #RSAbstractRegularTreeLayout,
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #testing }
RSAbstractHorizontalTreeLayout class >> isAbstract [
	^ self = RSAbstractHorizontalTreeLayout
]

{ #category : #initialization }
RSAbstractHorizontalTreeLayout >> initialize [
	super initialize.
	verticalGap := 3.
	horizontalGap := 20
]

{ #category : #'private - hook' }
RSAbstractHorizontalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each |
		childrenPosition := x + each width + self horizontalGap.
		treeSize := each height
			max: (self layout: (self computeChildrenFor: each) atPoint: childrenPosition @ y atLayer: aNumber + 1).
		middleOfTree := y + (treeSize / 2.0) - (each height / 2.0).
		translator translateTopLeftOf: each to: (x @ middleOfTree).
		y := y + treeSize + self verticalGap.
		self step ].
	^ y - aPoint y - self verticalGap
]

{ #category : #private }
RSAbstractHorizontalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self leftGap.
	nodesByLayer do: [ :eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [ :max :eachNode |
			translator translateTopLeftOf: eachNode to: (cursor @ eachNode encompassingRectangle top).
			max max: eachNode width ].
		cursor := cursor + layerDepthSize + self horizontalGap ]
]
