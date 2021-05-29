Extension { #name : #RSShape }

{ #category : #'*Roassal3-Interaction' }
RSShape >> draggable [
	self @ RSDraggableInteraction.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> labeled [
	self @ RSLabeledInteraction.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> popup [
	self @ RSPopup.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> popupText: aBlock [
	self @ (RSPopup text: aBlock).
]
