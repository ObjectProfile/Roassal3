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

	| hierarchy roots |
	super doInitialize: elements.

	hierarchy := IdentityDictionary new.
	roots := IdentitySet withAll: elements.

	self edgesDo: [ :anEdge | 
		| children child father |
		father := anEdge from.
		child := anEdge to.

		roots remove: child.

		children := hierarchy
			            at: father
			            ifAbsentPut: [ 
			            self childrenOf: father put: OrderedCollection new ].

		children add: child.

		self
			fatherOf: child put: father;
			indexInFatherOf: child put: children size;
			siblingsOf: child put: children ].

	roots do: [ :each | 
		self
			assert: (each propertyAt: #father) isNil;
			initDescriptor: each ]
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> firstWalk: aRootItemDescriptor [
	self subclassResponsibility
]

{ #category : #'initialize - release' }
RSHorizontalWalkBasedTreeLayout >> initDescriptor: aShape [

	| children |
	children := (self childrenOf: aShape) ifNil: [ 
		            self childrenOf: aShape put: OrderedCollection new ].

	children do: [ :each | self initDescriptor: each ]
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
