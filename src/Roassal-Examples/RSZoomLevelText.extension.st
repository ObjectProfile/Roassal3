Extension { #name : 'RSZoomLevelText' }

{ #category : '*Roassal-Examples' }
RSZoomLevelText class >> exampleSimpleUML [
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	builder renderer: RSDarkUMLClassRenderer new.
	builder build.
	builder canvas @ self.
	^ builder canvas open
]
