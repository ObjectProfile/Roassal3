"
TODO
"
Class {
	#name : #RSHorizontalDominanceTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'private - hook' }
RSHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
