Extension { #name : #Symbol }

{ #category : #'*Roassal' }
Symbol >> rsValue: anObject [
	^ anObject perform: self
]
