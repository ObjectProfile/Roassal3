Extension { #name : #Color }

{ #category : #'*Roassal3-Colors' }
Color >> translucent [
	"Make the color transparent"
	^ self alpha: 0.4
]
