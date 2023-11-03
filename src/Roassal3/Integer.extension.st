Extension { #name : 'Integer' }

{ #category : '*Roassal3' }
Integer >> choose: k [
	^ (k positive and: [ self >= k ])
		ifTrue: [ self factorial / (k factorial * (self - k) factorial) ]
		ifFalse: [ 0 ]
]
