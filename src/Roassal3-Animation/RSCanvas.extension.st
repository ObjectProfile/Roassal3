Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Animation' }
RSCanvas >> animationFrom: array [
	^ self compositeAnimation: self sequentialAnimation from: array
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> compositeAnimation: aRSCompositeAnimation from: array [
	aRSCompositeAnimation addAll: array.
	self addAnimation: aRSCompositeAnimation.
	^ aRSCompositeAnimation
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> currentTime [
	^ self timer currentTime
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
RSCanvas >> parallelAnimation [
	^ RSParallelAnimation new
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> parallelAnimationFrom: array [
	^ self compositeAnimation: self parallelAnimation from: array
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> sequentialAnimation [
	^ RSSequentialAnimation new
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> timer [
	^ self propertyAt: #timer ifAbsentPut: [ RSDefaultTimer new ]
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> timer: aRSAbstractTimer [
	self propertyAt: #timer put: aRSAbstractTimer
]

{ #category : #'*Roassal3-Animation' }
RSCanvas >> transitionAnimation [
	^ RSTransitionAnimation new
]
