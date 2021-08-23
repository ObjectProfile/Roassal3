Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedPositioning,
	#instVars : [
		'random'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> positionOfShape: aShape atDepth: depth atBreadth: breadth [

	^ (self rawPositionOfShape: aShape atDepth: depth atBreadth: breadth)
	  + (self random next asPoint * Float goldenRatio)
]

{ #category : #accessing }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> random [

	^ random ifNil: [ random := Random new ]
]

{ #category : #accessing }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> random: aRandom [

	random := aRandom
]

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> rawPositionOfShape: aShape atDepth: depth atBreadth: breadth [

	self explicitRequirement
]
