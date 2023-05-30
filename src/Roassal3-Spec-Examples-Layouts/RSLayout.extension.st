Extension { #name : #RSLayout }

{ #category : #'*Roassal3-Spec-Examples-Layouts' }
RSLayout class >> classesWithDefinitionsToEdit [

	^ ((self withAllSubclasses
		select: [ :cls | cls isAbstract not ]
		thenCollect: [ :cls | cls -> cls layoutDefinition ])
		select: [:tuple | tuple value notNil ])
		sorted: [ :a :b | a key name < b key name ]
]

{ #category : #'*Roassal3-Spec-Examples-Layouts' }
RSLayout class >> layoutDefinition [
	^ nil
]
