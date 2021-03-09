Extension { #name : #RSLineBuilder }

{ #category : #'*Roassal3-Sunburst' }
RSLineBuilder class >> sunburstBezier [
	^ self bezier
		controlPointsController: RSSunburstCPController new;
		yourself.
	
]
