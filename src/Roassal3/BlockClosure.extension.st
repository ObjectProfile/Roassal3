Extension { #name : #BlockClosure }

{ #category : #'*Roassal3' }
BlockClosure >> rsValue: value [
	^ self cull: value
]
