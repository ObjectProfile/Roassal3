Extension { #name : #TSCanvas }

{ #category : #'*Roassal3-Animation' }
TSCanvas >> animationFrom: array [
	| anime |
	anime := TSSequentialAnimation new.
	anime addAll: array.
	self addAnimation: anime.
	^ anime
]

{ #category : #'*Roassal3-Animation' }
TSCanvas >> newAnimation [
	| anime |
	anime := self tAnimation.
	self addAnimation: anime.
	^ anime
]

{ #category : #'*Roassal3-Animation' }
TSCanvas >> tAnimation [ 
	^ TSTransitionAnimation new.
]
