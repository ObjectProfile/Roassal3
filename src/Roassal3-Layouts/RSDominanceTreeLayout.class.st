"
TODO
"
Class {
	#name : #RSDominanceTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
RSDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
