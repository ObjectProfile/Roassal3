Extension { #name : #Symbol }

{ #category : #'*Roassal3-Scripting' }
Symbol >> rsValue: anObject [ 
	^ anObject perform: self
]
