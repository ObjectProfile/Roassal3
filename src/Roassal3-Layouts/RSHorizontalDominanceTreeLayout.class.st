Class {
	#name : #RSHorizontalDominanceTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
RSHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
