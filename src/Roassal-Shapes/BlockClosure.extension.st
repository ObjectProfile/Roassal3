Extension { #name : 'BlockClosure' }

{ #category : '*Roassal-Shapes' }
BlockClosure >> shapeFor: model [
	^ self cull: model
]
