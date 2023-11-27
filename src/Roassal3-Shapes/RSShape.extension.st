Extension { #name : #RSShape }

{ #category : #'*Roassal3-Shapes' }
RSShape >> asMarker [
	^ RSMarker new shape: self
]

{ #category : #'*Roassal3-Shapes' }
RSShape >> borderDo: aBlock [
	border ifNil: [ border := RSBorder new ].
	aBlock value: border
]

{ #category : #'*Roassal3-Shapes' }
RSShape >> withBorder [
	self border: RSBorder new
]
