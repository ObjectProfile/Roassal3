"
Dominance analysis from graph theory allows one to locate subordinated elements in a rooted dependency graph. It identifies the nesting structure for a dependency graph as a dominance horizontal tree
"
Class {
	#name : 'RSHorizontalDominanceTreeLayout',
	#superclass : 'RSAbstractHorizontalTreeLayout',
	#category : 'Roassal3-Layouts-Tree',
	#package : 'Roassal3-Layouts',
	#tag : 'Tree'
}

{ #category : 'private - hook' }
RSHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
