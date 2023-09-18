Extension { #name : #Symbol }

{ #category : #'*Roassal3' }
Symbol >> rsValue: anObject [
	^ anObject perform: self
]
