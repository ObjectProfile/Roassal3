Extension { #name : #Color }

{ #category : #'*Roassal-Colors' }
Color >> translucent [
	"Make the color transparent"
	^ self alpha: 0.4
]
