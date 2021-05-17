"
I am an abstract class for tidy algorithms that arrange trees lying on the concepts introduced in [1].

[1]: E. M. Reingold and J. S. Tilford, ""Tidier Drawings of Trees,"" in IEEE Transactions on Software Engineering, 
     vol. SE-7, no. 2, pp. 223-228, March 1981, doi: 10.1109/TSE.1981.234519, https://ieeexplore.ieee.org/document/1702828
"
Class {
	#name : #RSHorizontalWalkBasedTreeLayout,
	#superclass : #RSHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSHorizontalWalkBasedTreeLayout >> doInitialize: elements [

	| hierarchy |
	super doInitialize: elements.

	hierarchy := IdentityDictionary new.

	self edgesDo: [ :anEdge | 
		| children child father |
		father := anEdge from.
		child := anEdge to.

		children := hierarchy
			            at: father
			            ifAbsentPut: [ 
			            self childrenOf: father put: OrderedCollection new ].

		children add: child.

		self
			fatherOf: child put: father;
			indexInFatherOf: child put: children size;
			siblingsOf: child put: children ].

	elements do: [ :each | self initDescriptor: each ]
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> firstWalk: aRootItemDescriptor [
	self subclassResponsibility
]

{ #category : #'initialize - release' }
RSHorizontalWalkBasedTreeLayout >> initDescriptor: aDescriptor [

	(self childrenOf: aDescriptor) ifNil: [ 
		self childrenOf: aDescriptor put: OrderedCollection new ]
]

{ #category : #hook }
RSHorizontalWalkBasedTreeLayout >> layout: rootNodes atPoint: aPoint atLayer: aLayer [

	^ (rootNodes inject: aPoint into: [ :currentPoint :aRootShape | 
		   | y |
		   y := self
			        firstWalk: aRootShape;
			        secondWalk: aRootShape x: currentPoint x y: currentPoint y.

		   currentPoint x @ y ]) y
]

{ #category : #algorithm }
RSHorizontalWalkBasedTreeLayout >> secondWalk: v x: n y: m [
	self subclassResponsibility
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> spacing: aShape [

	^ self
		  is: aShape
		  ifRightMostSibling: [ Float goldenRatio ]
		  ifNotRightMostSibling: [ self verticalGap ]
]
