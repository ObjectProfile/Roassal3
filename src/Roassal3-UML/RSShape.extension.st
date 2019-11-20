Extension { #name : #RSShape }

{ #category : #'*Roassal3-UML' }
RSShape >> browseable [
	self when: RSMouseClick do: [ self model browse  ].
]
