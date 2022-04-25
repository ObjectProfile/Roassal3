Trait {
	#name : #RSTWalkBasedRegularTreeGapsChildrenSizeDepth,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #gap }
RSTWalkBasedRegularTreeGapsChildrenSizeDepth >> gapAmongParent: aParent andChild: aChild default: aGap layout: layout [

	^ (layout childrenOf: aParent) size * aGap + aGap
]
