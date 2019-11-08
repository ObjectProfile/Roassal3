Extension { #name : #RSShape }

{ #category : #'*Roassal3-Interaction' }
RSShape >> draggable [
	self @ RSDraggable.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> labeled [
	self @ RSLabeled.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> popup [
	self @ RSPopup.
]
