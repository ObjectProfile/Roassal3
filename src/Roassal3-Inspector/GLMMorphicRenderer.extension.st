Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Roassal3-Inspector' }
GLMMorphicRenderer >> renderRoassal3Presentation: aPresentation [
	^ GLMMorphicRoassal3Renderer render: aPresentation from: self
]
