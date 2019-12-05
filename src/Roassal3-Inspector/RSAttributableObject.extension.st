Extension { #name : #RSAttributableObject }

{ #category : #'*Roassal3-Inspector' }
RSAttributableObject >> gtInspectorAttributes: composite [
	<gtInspectorPresentationOrder: 25>
	self hasAttributes ifFalse: [ ^ self ].
	self attributes gtInspectorItemsIn: composite
]
