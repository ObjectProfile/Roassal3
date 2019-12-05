Extension { #name : #RSEdgeBuilder }

{ #category : #'*Roassal3-Sunburst' }
RSEdgeBuilder class >> sunburstBezier [
	^ self bezier
		controlPointsController: RSSunburstCPController new;
		yourself.
	
]
