Extension { #name : #Rectangle }

{ #category : #'*Roassal3-Pharo7' }
Rectangle >> floatCenter [
	"Answer the float point at the center of the receiver."
	^ self topLeft + self bottomRight / 2.0
]

{ #category : #'*Roassal3-Pharo7' }
Rectangle class >> floatCenter: centerPoint extent: extentPoint [ 
	"Answer an instance of me whose center is centerPoint and width 
	by height is extentPoint."
	^self origin: centerPoint - (extentPoint/2.0) extent: extentPoint
]
