"
TODO
"
Class {
	#name : #TSDominanceTreeLayout,
	#superclass : #TSAbstractVerticalTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'hook-private' }
TSDominanceTreeLayout >> computeChildrenFor: aNode [
	^ self childrenWithHighestNestingLevelFor: aNode
]
