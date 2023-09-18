Extension { #name : #LinearGradientPaint }

{ #category : #'*Roassal3-Colors' }
LinearGradientPaint >> asScale [
	| sc |
	sc := NSScale linear.
	sc domain: (colorRamp collect: #key).
	sc range: (colorRamp collect: #value).
	^ sc
]
