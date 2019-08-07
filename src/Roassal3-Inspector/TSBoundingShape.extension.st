Extension { #name : #TSBoundingShape }

{ #category : #'*Roassal3-Inspector' }
TSBoundingShape >> trachelCopy [
	^ super trachelCopy
		matrix: self matrix copy;
		yourself.
]
