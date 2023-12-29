Extension { #name : 'RSBackInterpolator' }

{ #category : '*Roassal-Inspector' }
RSBackInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #overshoot }
]
