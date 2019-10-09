"
TODO
"
Class {
	#name : #TSHorizontalDominanceTreeLayout,
	#superclass : #TSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
TSHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
