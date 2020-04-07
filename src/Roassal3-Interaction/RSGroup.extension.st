Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Interaction' }
RSGroup >> @ interaction [
	self do: [ :e | e @ interaction ].
]
