Trait {
	#name : 'RSTWalkBasedRegularTreeGapsChildrenSizeDepth',
	#category : 'Roassal3-Layouts-Core',
	#package : 'Roassal3-Layouts',
	#tag : 'Core'
}

{ #category : 'gap' }
RSTWalkBasedRegularTreeGapsChildrenSizeDepth >> gapAmongParent: aParent andChild: aChild default: aGap layout: layout [

	^ (layout childrenOf: aParent) size * aGap + aGap
]
