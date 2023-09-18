Extension { #name : #RSMondrian }

{ #category : #'*Roassal3-GraphViz' }
RSMondrian >> graphvizLine [
	lineBuilder := RSLineBuilder graphviz.
	lineBuilder canvas: canvas.
	lineBuilder shapes: (canvas nodes select: #hasModel).
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]
