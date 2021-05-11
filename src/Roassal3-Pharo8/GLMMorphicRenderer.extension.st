Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Roassal3-Pharo8' }
GLMMorphicRenderer >> renderRoassal3Presentation: aPresentation [
	^ GLMMorphicRoassal3Renderer render: aPresentation from: self
]
