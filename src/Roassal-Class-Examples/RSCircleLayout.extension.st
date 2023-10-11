Extension { #name : #RSCircleLayout }

{ #category : #'*Roassal-Class-Examples' }
RSCircleLayout class >> example1 [
	| aLayout objects |
	aLayout := self new.
	aLayout center: 200@200.
	aLayout radius: 100.
	objects := RSBox models: (1 to: 10).
	aLayout on: objects.
	^ RSCanvas new
		addAll: objects;
		@ RSCanvasController;
		open
]

{ #category : #'*Roassal-Class-Examples' }
RSCircleLayout class >> example2 [
	| nodes canvas shapes |
	nodes := (1 to: 5).

	canvas := RSCanvas new.
	shapes := RSCircle models: nodes.
	shapes size: 30.
	canvas addAll: shapes.

	self new radius: 20; on: shapes.
	canvas @ RSCanvasController.
	^ canvas open
]
