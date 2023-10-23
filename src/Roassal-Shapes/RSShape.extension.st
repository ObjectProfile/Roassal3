Extension { #name : 'RSShape' }

{ #category : '*Roassal-Shapes' }
RSShape >> asMarker [
	^ RSMarker new shape: self
]

{ #category : '*Roassal-Shapes' }
RSShape >> borderDo: aBlock [
	border ifNil: [ border := RSBorder new ].
	aBlock value: border
]

{ #category : '*Roassal-Shapes' }
RSShape >> withBorder [
	self border: RSBorder new
]
