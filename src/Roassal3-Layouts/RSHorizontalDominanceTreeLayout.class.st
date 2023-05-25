"
TODO
"
Class {
	#name : #RSHorizontalDominanceTreeLayout,
	#superclass : #RSAbstractHorizontalTreeLayout,
	#category : #'Roassal3-Layouts-Tree'
}

{ #category : #'private - hook' }
RSHorizontalDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
