"
Dominance analysis from graph theory allows one to locate subordinated elements in a rooted dependency graph. It identifies the nesting structure for a dependency graph as a dominance vertical tree
"
Class {
	#name : #RSDominanceTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #'private - hook' }
RSDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
