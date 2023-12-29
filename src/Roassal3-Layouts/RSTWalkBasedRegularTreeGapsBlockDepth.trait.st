Trait {
	#name : 'RSTWalkBasedRegularTreeGapsBlockDepth',
	#instVars : [
		'block'
	],
	#category : 'Roassal3-Layouts-Core',
	#package : 'Roassal3-Layouts',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSTWalkBasedRegularTreeGapsBlockDepth >> depthBlock: aBlock [

	block := aBlock
]

{ #category : 'gap' }
RSTWalkBasedRegularTreeGapsBlockDepth >> gapAmongParent: aParent andChild: aChild default: aGap layout: layout [

	^ block value: aParent value: aChild value: aGap
]
