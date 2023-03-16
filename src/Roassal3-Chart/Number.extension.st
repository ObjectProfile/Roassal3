Extension { #name : #Number }

{ #category : #'*Roassal3-Chart' }
Number >> to: upperBound count: count [
	"Answer an Interval from the receiver up to the argument, stop,
	incrementing by step."

	| answer |
	count = 1 ifTrue: [ ^ Array with: self ].

	answer := self to: upperBound by: (upperBound - self) / (count - 1).
	"We need to do a bit of fiddling because of the float precision"
	^ answer size = count
			ifTrue: [ answer ]
			ifFalse: [ answer asArray, { upperBound } ]
]
