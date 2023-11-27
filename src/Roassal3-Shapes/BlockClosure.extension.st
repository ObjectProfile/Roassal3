Extension { #name : #BlockClosure }

{ #category : #'*Roassal3-Shapes' }
BlockClosure >> shapeFor: model [
	^ self cull: model
]
