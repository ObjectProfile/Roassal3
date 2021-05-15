"
I am an abstract class for tidy algorithms that arrange trees lying on the concepts introduced in [1].

[1]: E. M. Reingold and J. S. Tilford, ""Tidier Drawings of Trees,"" in IEEE Transactions on Software Engineering, 
     vol. SE-7, no. 2, pp. 223-228, March 1981, doi: 10.1109/TSE.1981.234519, https://ieeexplore.ieee.org/document/1702828
"
Class {
	#name : #RSHorizontalWalkBasedTreeLayout,
	#superclass : #RSHorizontalTreeLayout,
	#instVars : [
		'marginAfterRightmostSibling',
		'marginBetweenAdjacentLayers',
		'marginBetweenAdjacentSiblings'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> descriptor [
	self subclassResponsibility
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> firstWalk: aRootItemDescriptor [
	self subclassResponsibility
]

{ #category : #'initialize - release' }
RSHorizontalWalkBasedTreeLayout >> initDescriptor: aDescriptor [
	self subclassResponsibility
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> marginAfterRightmostSibling: anObject [
	marginAfterRightmostSibling := anObject
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> marginBetweenAdjacentLayers: anObject [
	marginBetweenAdjacentLayers := anObject
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> marginBetweenAdjacentSiblings: anObject [
	marginBetweenAdjacentSiblings := anObject
]

{ #category : #algorithm }
RSHorizontalWalkBasedTreeLayout >> secondWalk: v x: n y: m [
	self subclassResponsibility
]

{ #category : #accessing }
RSHorizontalWalkBasedTreeLayout >> spacing: aHierarchyItem [
	^ aHierarchyItem isRightMostSibling
		ifTrue: [ marginAfterRightmostSibling ]
		ifFalse: [ marginBetweenAdjacentSiblings ]
]

{ #category : #API }
RSHorizontalWalkBasedTreeLayout >> walkPreOrderVisited: aSequenceableOfAssociations [
	| aRootItemDescriptor descriptor aSequenceableOfHierarchyItems |
	"Initialize the dictionary that will be returned eventually."
	descriptor := IdentityDictionary new.

	"Build descriptors corresponding to hierarchy items."
	aSequenceableOfHierarchyItems := aSequenceableOfAssociations
		collect: [ :anAssociation | 
			| aDescriptor extent aHierarchyItem |
			"Get the original extent with respect to 0 @ 0."
			aHierarchyItem := anAssociation key.
			extent := anAssociation value.

			"Build and return the descriptor associated to item v."
			aDescriptor := self descriptor
				hierarchyItem: aHierarchyItem;
				containedIn: descriptor;
				width: extent x;
				height: extent y;
				yourself.

			"Initialize the descriptor's fields according to the algorithm needs. "
			self initDescriptor: aDescriptor.

			"Finally return the initialized descriptor."
			descriptor at: aHierarchyItem put: aDescriptor ].

	"Retrieve the descriptor for the root item"
	aRootItemDescriptor := aSequenceableOfHierarchyItems first.

	"Start the algorithm."
	self
		zeroWalk: aSequenceableOfHierarchyItems;
		firstWalk: aRootItemDescriptor;
		secondWalk: aRootItemDescriptor x: 0 y: 0.

	"Finally return the mapping"
	^ descriptor
]

{ #category : #algorithm }
RSHorizontalWalkBasedTreeLayout >> zeroWalk: aSequenceableOfHierarchyItems [
	"Auxiliary walk message not present in the published implementations."

	
]
