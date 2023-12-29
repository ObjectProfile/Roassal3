Extension { #name : 'RSLineBuilder' }

{ #category : '*Roassal-Sunburst' }
RSLineBuilder class >> sunburstBezier [
	^ self bezier
		controlPointsController: RSSunburstCPController new;
		yourself
]
