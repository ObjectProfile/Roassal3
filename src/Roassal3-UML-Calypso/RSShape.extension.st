Extension { #name : #RSShape }

{ #category : #'*Roassal3-UML-Calypso' }
RSShape >> browseable [
	self when: RSMouseClick do: [ self model browse  ].
]
