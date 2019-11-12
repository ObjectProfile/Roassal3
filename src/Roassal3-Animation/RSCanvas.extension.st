Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Animation' }
RSCanvas >> animationFrom: array [
	| anime |
	anime := RSSequentialAnimation new.
	anime addAll: array.
	self addAnimation: anime.
	^ anime
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> newAnimation [
	"Define a new transition animation, schedule it, and return it (useful to tune it).

-=-==-=-=-=
	c := RSCanvas new.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c add: b.
	c newAnimation
			from: -100 @ -100;
			to: 100 @ 100;
			on: b set: #position:.
	c
-=-==-=-=-=
		
	"
	| anime |
	anime := self transitionAnimation.
	self addAnimation: anime.
	^ anime
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> transitionAnimation [ 
	^ RSTransitionAnimation new
]
