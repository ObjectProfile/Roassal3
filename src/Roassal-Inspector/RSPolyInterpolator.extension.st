Extension { #name : 'RSPolyInterpolator' }

{ #category : '*Roassal-Inspector' }
RSPolyInterpolator >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ self inspectorWithTools: { #exponent }
]
