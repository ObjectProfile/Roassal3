Extension { #name : 'RSBackInterpolator' }

{ #category : '*Roassal3-Inspector' }
RSBackInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #overshoot }.
	
]
