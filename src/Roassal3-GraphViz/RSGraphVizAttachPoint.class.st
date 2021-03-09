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
	endDistance
		ifNil: [ endDistance := points last - p ].
	points at: points size put: p + endDistance.
	^ points last
]

{ #category : #'public - hooks' }
RSGraphVizAttachPoint >> basicStartingPointOf: anEdge [
	| p |
	p := anEdge from position.
	startDistance
		ifNil: [ startDistance := points first - p].
	points at: 1 put: p + startDistance.
	^ points first
]

{ #category : #accessing }
RSGraphVizAttachPoint >> points [
	^ points
]

{ #category : #accessing }
RSGraphVizAttachPoint >> points: aCollection [
	self assert: aCollection isNotEmpty description: 'Can not be empty'.
	points := aCollection.
]
