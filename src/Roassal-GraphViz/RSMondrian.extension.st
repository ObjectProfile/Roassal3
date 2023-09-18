Extension { #name : #RSMondrian }

{ #category : #'*Roassal-GraphViz' }
RSMondrian >> graphvizLine [
	lineBuilder := RSLineBuilder graphviz.
	lineBuilder canvas: canvas.
	lineBuilder shapes: (canvas nodes select: #hasModel).
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]
