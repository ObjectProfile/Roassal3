Extension { #name : #RSObjectWithProperty }

{ #category : #'*Roassal-Pharo8' }
RSObjectWithProperty >> gtInspectorProperties: composite [
	<gtInspectorPresentationOrder: 25>
	self hasProperties ifFalse: [ ^ self ].
	self properties gtInspectorItemsIn: composite
]
