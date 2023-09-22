Extension { #name : 'RSElasticInterpolator' }

{ #category : '*Roassal3-Inspector' }
RSElasticInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #amplitude. #period }
]
