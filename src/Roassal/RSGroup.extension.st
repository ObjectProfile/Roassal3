Extension { #name : 'RSGroup' }

{ #category : '*Roassal' }
RSGroup >> entriesAtRectangle: aRectangle [
	^ self select: [ :each | each encompassingRectangle intersects: aRectangle ]
]
