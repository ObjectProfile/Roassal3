"
I generate a random position for a given shape
"
Trait {
	#name : #RSTWalkBasedRegularTreeLayoutRandomizedPositioning,
	#instVars : [
		'random'
	],
	#category : #'Roassal-Layouts-Traits'
}

{ #category : #positioning }
RSTWalkBasedRegularTreeLayoutRandomizedPositioning >> positionOfShape: aShape atDepth: depth atBreadth: breadth [
	| goldenRatio |
	goldenRatio := 1.618033988749894848.
	^ (self rawPositionOfShape: aShape atDepth: depth atBreadth: breadth)
	  + (self random next asPoint * goldenRatio)
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
