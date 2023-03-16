Extension { #name : #RSLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSLayout class >> classesWithDefinitionsToEdit [

	^ self withAllSubclasses
		collect: [ :cls | cls -> cls layoutDefinition ]
		thenSelect: [:tuple | tuple key isAbstract not and: [ tuple value notNil ] ]
]

{ #category : #'*Roassal3-Spec-Examples' }
RSLayout class >> layoutDefinition [
	^ nil
]
