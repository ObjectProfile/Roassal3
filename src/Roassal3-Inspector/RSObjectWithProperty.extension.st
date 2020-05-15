Extension { #name : #RSObjectWithProperty }

{ #category : #'*Roassal3-Inspector' }
RSObjectWithProperty >> gtInspectorProperties: composite [
	<gtInspectorPresentationOrder: 25>
	self hasProperties ifFalse: [ ^ self ].
	self properties gtInspectorItemsIn: composite
]
