"
This attach point is used only by graphviz layout with graphviz line
"
Class {
	#name : #RSGraphvizAttachPoint,
	#superclass : #RSAttachPoint,
	#instVars : [
		'points',
		'startDistance',
		'endDistance'
	],
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #'public - hooks' }
RSGraphvizAttachPoint >> basicEndingPointOf: anEdge [
	| p |
	p := anEdge to position.
	points at: points size put: p + endDistance.
	^ points last
]

{ #category : #'public - hooks' }
RSGraphvizAttachPoint >> basicStartingPointOf: anEdge [
	| p |
	p := anEdge from position.

	points at: 1 put: p + startDistance.
	^ points first
]

{ #category : #accessing }
RSGraphvizAttachPoint >> points [
	^ points
]

{ #category : #accessing }
RSGraphvizAttachPoint >> points: aCollection edge: anEdge [
	|p1 p2 |
	self assert: aCollection isNotEmpty description: 'Can not be empty'.

	points := aCollection.
	p1 := anEdge from position.
	p2 := anEdge to position.
	startDistance := points first - p1.
	endDistance := points last - p2
]
