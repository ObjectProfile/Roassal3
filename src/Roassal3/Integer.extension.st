Extension { #name : 'Integer' }

{ #category : '*Roassal3' }
Integer >> choose: k [
	^ (k positive and: [ self >= k ])
		ifTrue: [ self factorial / (k factorial * (self - k) factorial) ]
		ifFalse: [ 0 ]
]

{ #category : '*Roassal3' }
Integer >> ifZero: zBlock ifNotZero: nzBlock [
	^ self = 0
		ifTrue: [ zBlock cull: self ]
		ifFalse: [ nzBlock cull: self ]
]
