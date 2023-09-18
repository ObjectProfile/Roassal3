Extension { #name : #RSShape }

{ #category : #'*Roassal3-Animation' }
RSShape >> newAnimation [
	"Create a new animation"
	^ parent ifNil: [
		| animations anime |
		animations := self propertyAt: #todoAnimations ifAbsentPut: [ OrderedCollection new ].
		anime := RSTransitionAnimation new.
		animations add: anime.
		anime.
		 ] ifNotNil: [ parent newAnimation ]
]
