Trait {
	#name : #RSTWalkBasedRegularTreeGapsPyramidalDepth,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #gap }
RSTWalkBasedRegularTreeGapsPyramidalDepth >> gapAmongParent: aParent andChild: aChild default: aGap layout: layout [

	| childrenSize i j |
	i := self childIndexOf: aChild.
	childrenSize := (self siblingsOf: aChild) size.

	j := i <= childrenSize halved ceiling
		     ifTrue: [ i ]
		     ifFalse: [ childrenSize - i + 1 ].

	^ j * aGap + aGap
]
