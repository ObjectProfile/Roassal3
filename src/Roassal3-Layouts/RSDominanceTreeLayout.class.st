"
TODO
"
Class {
	#name : #RSDominanceTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Tree'
}

{ #category : #'private - hook' }
RSDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
