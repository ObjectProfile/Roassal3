Extension { #name : 'RSRectanglePackLayout' }

{ #category : '*Roassal-Class-Examples' }
RSRectanglePackLayout class >> example1 [
	<noTest>
	| numberOfBoxes random shapes canvas |
		numberOfBoxes := 900.
	random := Random seed: 42.
	shapes := RSGroup new.
	numberOfBoxes timesRepeat: [
		shapes add: (RSBox new width: (random nextInteger: 40); height: (random nextInteger: 40)) ].

	canvas := RSCanvas new.
	canvas addAll: shapes.
	self new useProgressBar; on: shapes.
	canvas @ RSCanvasController.
	^ canvas open
]

{ #category : '*Roassal-Class-Examples' }
RSRectanglePackLayout class >> example2 [
	| nodes canvas shapes |
	nodes := (1 to: 20) asArray shuffleBy: (Random seed: 42).

	canvas := RSCanvas new.
	shapes := RSCircle models: nodes.
	shapes size: 30.
	canvas addAll: shapes.
	RSNormalizer size
	    shapes: shapes;
	    normalize.

	self on: shapes.
	canvas zoomToFit.
	^ canvas open
]
