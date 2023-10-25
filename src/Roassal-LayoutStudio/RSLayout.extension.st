Extension { #name : 'RSLayout' }

{ #category : '*Roassal-LayoutStudio' }
RSLayout class >> classesWithDefinitionsToEdit [

	^ ((self withAllSubclasses
		select: [ :cls | cls isAbstract not ]
		thenCollect: [ :cls | cls -> cls layoutDefinition ])
		select: [:tuple | tuple value notNil ])
		sorted: [ :a :b | a key name < b key name ]
]

{ #category : '*Roassal-LayoutStudio' }
RSLayout class >> layoutDefinition [
	^ nil
]
