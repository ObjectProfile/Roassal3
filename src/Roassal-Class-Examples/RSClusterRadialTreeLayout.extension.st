Extension { #name : #RSClusterRadialTreeLayout }

{ #category : #'*Roassal-Class-Examples' }
RSClusterRadialTreeLayout class >> exampleWithNumber [
	| canvas shapes color |
	canvas := RSCanvas new.

	color := RSColorPalette sequential bupu3.
	shapes := (1 to: 100) collect: [ :m |
		RSBox new
			size: 7;
			model: m;
			draggable;
			withBorder;
			color: (color scale: m);
			yourself.
		 ].
	RSLineBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	canvas shapes @ RSHighlightable red.
	self on: shapes.
	canvas zoomToFit.
	^ canvas open
]
