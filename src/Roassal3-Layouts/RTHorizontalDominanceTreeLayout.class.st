Class {
	#name : #RTHorizontalDominanceTreeLayout,
	#superclass : #RTAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts'
}

{ #category : #'hook-private' }
RTHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
