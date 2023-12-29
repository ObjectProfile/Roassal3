Extension { #name : #LinearGradientPaint }

{ #category : #'*Roassal-Colors' }
LinearGradientPaint >> asScale [
	| sc |
	sc := NSScale linear.
	sc domain: (colorRamp collect: #key).
	sc range: (colorRamp collect: #value).
	^ sc
]
