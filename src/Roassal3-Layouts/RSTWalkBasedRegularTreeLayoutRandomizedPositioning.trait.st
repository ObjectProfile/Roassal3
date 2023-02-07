Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedPositioning,
	#instVars : [
		'random'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> positionOfShape: aShape atDepth: depth atBreadth: breadth [
	| goldenRatio |
	goldenRatio := 1.618033988749894848.
	^ (self rawPositionOfShape: aShape atDepth: depth atBreadth: breadth)
	  + (self random next asPoint * goldenRatio)
]
