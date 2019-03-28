Extension { #name : #LinearGradientPaint }

{ #category : #'*Roassal3-Colors' }
LinearGradientPaint >> asScale [ 
	| sc |
	sc := TSScale linear.
	sc domain: (colorRamp collect: #key).
	sc range: (colorRamp collect: #value).
	^ sc
]
