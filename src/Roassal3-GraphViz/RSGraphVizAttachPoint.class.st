"
This attach point is used only by graphviz layout with graphviz line
"
Class {
	#name : #RSGraphVizAttachPoint,
	#superclass : #RSAttachPoint,
	#instVars : [
		'points',
		'startDistance',
		'endDistance'
	],
	#category : #'Roassal3-GraphViz'
}

{ #category : #'public - hooks' }
RSGraphVizAttachPoint >> basicEndingPointOf: anEdge [
	| p |
	p := anEdge to position.
	points at: points size put: p + endDistance.
	^ points last
]

{ #category : #'public - hooks' }
RSGraphVizAttachPoint >> basicStartingPointOf: anEdge [
	| p |
	p := anEdge from position.
	
	points at: 1 put: p + startDistance.
	^ points first
]

{ #category : #accessing }
RSGraphVizAttachPoint >> points [
	^ points
]

{ #category : #accessing }
RSGraphVizAttachPoint >> points: aCollection edge: anEdge [
	|p1 p2 | 
	self assert: aCollection isNotEmpty description: 'Can not be empty'.
	
	points := aCollection.
	p1 := anEdge from position.
	p2 := anEdge to position.
	startDistance := points first - p1.
	endDistance := points last - p2.
]
