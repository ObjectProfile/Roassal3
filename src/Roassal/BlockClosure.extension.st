Extension { #name : #BlockClosure }

{ #category : #'*Roassal' }
BlockClosure >> rsValue: value [
	^ self cull: value
]
