"
TODO
"
Class {
	#name : #RSAbstractVerticalTreeLayout,
	#superclass : #RSAbstractRegularTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
RSAbstractVerticalTreeLayout class >> isAbstract [
	^ self = RSAbstractVerticalTreeLayout
]

{ #category : #'hook-private' }
RSAbstractVerticalTreeLayout >> computeChildrenFor: aNode [
	self subclassResponsibility
]

{ #category : #'initialize-release' }
RSAbstractVerticalTreeLayout >> initialize [
	super initialize.
	verticalGap := 20.
	horizontalGap := 3
]

{ #category : #'hook-private' }
RSAbstractVerticalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each | 
		childrenPosition := y + each height + self verticalGap.
		treeSize := each width
			max: (self layout: (self computeChildrenFor: each) atPoint: x @ childrenPosition atLayer: aNumber + 1).
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
