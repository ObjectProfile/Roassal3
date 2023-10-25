Extension { #name : 'RSShape' }

{ #category : '*Roassal-Interaction' }
RSShape >> browseable [
	self when: RSMouseClick do: [ self model browse  ] for: self
]

{ #category : '*Roassal-Interaction' }
RSShape >> draggable [
	self @ RSDraggable
]

{ #category : '*Roassal-Interaction' }
RSShape >> hasShadow [
	^ self shadow notNil
]

{ #category : '*Roassal-Interaction' }
RSShape >> labeled [
	self @ RSLabeled
]

{ #category : '*Roassal-Interaction' }
RSShape >> popup [
	self @ RSPopup
]

{ #category : '*Roassal-Interaction' }
RSShape >> popupText: aBlock [
	self @ (RSPopup text: aBlock)
]

{ #category : '*Roassal-Interaction' }
RSShape >> removeShadow [
	| key |
	key := #shadow.
	(self hasProperty: key) ifFalse: [ ^ self ].
	"self removeInteractionIfPresent: RSShadowInteraction."
	self shadow remove.
	self removeKey: key
]

{ #category : '*Roassal-Interaction' }
RSShape >> shadow [
	^ self propertyAt: #shadow
]

{ #category : '*Roassal-Interaction' }
RSShape >> shadow: aRSBox [
	^ self propertyAt: #shadow put: aRSBox
]
