Extension { #name : #Random }

{ #category : #'*Roassal3-Scales' }
Random >> rsNext: limit [
	^ self rsNext: 0 and: limit.
]

{ #category : #'*Roassal3-Scales' }
Random >> rsNext: u and: v [
	^ TSScale linear range: {u. v}; scale: self next.
]
