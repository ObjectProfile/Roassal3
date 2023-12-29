Extension { #name : 'RSElasticInterpolator' }

{ #category : '*Roassal-Inspector' }
RSElasticInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #amplitude. #period }
]
