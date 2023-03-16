"
TODO
"
Class {
	#name : #RSDominanceTreeLayout,
	#superclass : #RSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'private - hook' }
RSDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
