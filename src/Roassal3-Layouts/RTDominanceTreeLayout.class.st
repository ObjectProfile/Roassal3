Class {
	#name : #RTDominanceTreeLayout,
	#superclass : #RTAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts'
}

{ #category : #'hook-private' }
RTDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
