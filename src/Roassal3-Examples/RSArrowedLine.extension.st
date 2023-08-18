Extension { #name : #RSArrowedLine }

{ #category : #'*Roassal3-Examples' }
RSArrowedLine class >> exampleArrow [
	| arrow |
	arrow := self new.
	^ (Smalltalk tools inspector inspect: arrow) window.
]
