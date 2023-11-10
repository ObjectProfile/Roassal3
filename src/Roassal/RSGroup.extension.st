Extension { #name : 'RSGroup' }

{ #category : '*Roassal' }
RSGroup >> entriesAtPoint: position [
	| result |
	result := OrderedCollection new.
	self reverseDo: [ :entry |
		entry addEntriesIn: result position: position.
	].
	^ result
]

{ #category : '*Roassal' }
RSGroup >> entriesAtRectangle: aRectangle [
	^ self select: [ :each | each encompassingRectangle intersects: aRectangle ]
]
