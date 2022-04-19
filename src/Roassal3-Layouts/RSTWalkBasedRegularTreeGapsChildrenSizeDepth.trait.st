Trait {
	#name : #RSTWalkBasedRegularTreeGapsChildrenSizeDepth,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #gap }
RSTWalkBasedRegularTreeGapsChildrenSizeDepth >> gapAmongParent: aParent andChild: aChild default: aGap layout: layout [

	| size |
	size := (layout childrenOf: aParent) size.

	size := size >> 1 + 2 - size odd asBit.

	^ size * aGap
]
