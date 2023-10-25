Extension { #name : 'RSPolyline' }

{ #category : '*Roassal-Examples' }
RSPolyline class >> exampleArrowedPolyline [
	| line |
	line := self new.
	line controlPoints: {0@0. 100@0. 0@ -100 }.
	line markerEnd: (RSShapeFactory arrow size: 10).
	line color: Color purple.
	^ RSCanvas new
		add: line;
		open
]

{ #category : '*Roassal-Examples' }
RSPolyline class >> examplePolyline [
	| line |
	line := self new.
	line controlPoints: {0@0. 100@ -50.  0@ -100. 50@ 0}.
	^ (Smalltalk tools inspector inspect: line) window
]
