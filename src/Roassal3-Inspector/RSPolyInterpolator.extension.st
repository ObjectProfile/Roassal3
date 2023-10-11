Extension { #name : 'RSPolyInterpolator' }

{ #category : '*Roassal3-Inspector' }
RSPolyInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #exponent }
]
