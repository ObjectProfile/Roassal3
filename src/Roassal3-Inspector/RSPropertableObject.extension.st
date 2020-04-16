Extension { #name : #RSPropertableObject }

{ #category : #'*Roassal3-Inspector' }
RSPropertableObject >> gtInspectorProperties: composite [
	<gtInspectorPresentationOrder: 25>
	self hasProperties ifFalse: [ ^ self ].
	self properties gtInspectorItemsIn: composite
]
