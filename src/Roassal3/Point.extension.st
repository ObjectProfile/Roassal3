Extension { #name : 'Point' }

{ #category : '*Roassal3' }
Point >> asFloatPointRound: numberOfWishedDecimal [

	| aPoint |
	aPoint := self asFloatPoint.

	^ (aPoint x round: numberOfWishedDecimal)
	  @ (aPoint y round: numberOfWishedDecimal)
]

{ #category : '*Roassal3' }
Point >> distanceToOrigin [

	^ self distanceTo: 0 @ 0
]

{ #category : '*Roassal3' }
Point >> unitAffine: aPoint at: aParam [

	| t |
	t := aParam min: 1 max: 0.

	^ self * t + (1 - t * aPoint)
]

{ #category : '*Roassal3' }
Point >> unitAffine: aPoint at: aParam and: anotherPoint at: anotherParam [

	| t s |
	t := aParam min: 1 max: 0.
	s := anotherParam min: 1 max: 0.


	^ self * t + (aPoint * s) + (1 - t - s * anotherPoint)
]

{ #category : '*Roassal3' }
Point >> xMinusY [

	^ self x - self y
]

{ #category : '*Roassal3' }
Point >> yMinusX [

	^ self y - self x
]

{ #category : '*Roassal3' }
Point >> π [

	^ (self angle / Float π) asFraction
		  ifNegative: [ :radians | radians + 2 ]
		  ifNotNegative: [ :radians | radians ]
]
