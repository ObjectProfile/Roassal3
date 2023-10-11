Extension { #name : #RSLocation }

{ #category : #'*Roassal-Shapes' }
RSLocation >> stick: movableShape on: baseShape [
	| block |
	block := [ self move: movableShape on: baseShape ].
	block value.
	baseShape
		when: RSExtentChangedEvent do: block for: self;
		when: RSPositionChangedEvent do: block for: self
]
