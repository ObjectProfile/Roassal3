Extension { #name : #RSShape }

{ #category : #'*Roassal3-UML' }
RSShape >> browseable [
	self when: RSMouseClickEvent do: [ self model browse  ].
]
