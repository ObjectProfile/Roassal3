Extension { #name : #Rectangle }

{ #category : #'*Roassal3-Trachel' }
Rectangle >> rsCenter [
	^(origin + corner) / 2.0
]

{ #category : #'*Roassal3-Trachel' }
Rectangle class >> rsCenter: centerPoint extent: extentPoint [
	"Answer an instance of me whose center is centerPoint and width 
	by height is extentPoint.  "

	^ self
		origin: centerPoint - (extentPoint / 2.0)
		extent: extentPoint asNonFractionalPoint
]
