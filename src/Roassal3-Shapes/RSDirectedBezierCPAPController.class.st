"
Directed controlpoints controller based on attach point from each line.

This directed bezier uses 3 control points
"
Class {
	#name : #RSDirectedBezierCPAPController,
	#superclass : #RSAbstractCPAPController,
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #hooks }
RSDirectedBezierCPAPController >> controlPointsFrom: fromPoint to: toPoint [
	| a b vector u unit mid height width dist |
	a := fromPoint.
	b := toPoint.
	dist := a distanceTo: b.
	height := dist * 0.20.
	width := dist * 0.50.
	vector := a - b.
	u := vector normal.
	unit := vector / (vector r max: 1).
	mid := a - (unit * height).
	mid := mid + (u * width).
	^ {fromPoint.
	mid.
	toPoint.}
]
