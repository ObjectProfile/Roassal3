Extension { #name : #RSShape }

{ #category : #'*Roassal3-Interaction' }
RSShape >> browseable [
	self when: RSMouseClick do: [ self model browse  ] for: self
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> draggable [
	self @ RSDraggable
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> hasShadow [
	^ self shadow notNil
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> labeled [
	self @ RSLabeled
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> popup [
	self @ RSPopup
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> popupText: aBlock [
	self @ (RSPopup text: aBlock)
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> removeShadow [
	| key |
	key := #shadow.
	(self hasProperty: key) ifFalse: [ ^ self ].
	"self removeInteractionIfPresent: RSShadowInteraction."
	self shadow remove.
	self removeKey: key.
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> shadow [
	^ self propertyAt: #shadow
]

{ #category : #'*Roassal3-Interaction' }
RSShape >> shadow: aRSBox [
	^ self propertyAt: #shadow put: aRSBox
]
