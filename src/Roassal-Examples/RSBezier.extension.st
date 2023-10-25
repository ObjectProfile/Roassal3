Extension { #name : 'RSBezier' }

{ #category : '*Roassal-Examples' }
RSBezier class >> exampleBezier [
	| bezier |
	bezier := self new.
	bezier controlPoints: {0@0. 100@ -50.  0@ -100. 50@ 0}.
	^ (Smalltalk tools inspector inspect: bezier) window
]

{ #category : '*Roassal-Examples' }
RSBezier class >> exampleControlPointsController [
	| bezier controller points |
	bezier := self new.
	points := {0@0. 100@ -50.  0@ -100. 50@ 0} collect: [:point |
		RSCircle new
			radius: 5;
			position: point;
			draggable;
			yourself ].

	controller := RSCustomCPController new
		models: points;
		yourself.
	bezier controlPointsController: controller.

	^ RSCanvas new
		add: bezier;
		addAll: points;
		open
]
