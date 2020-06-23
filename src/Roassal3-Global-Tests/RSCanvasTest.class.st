Class {
	#name : #RSCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'c'
	],
	#category : #'Roassal3-Global-Tests-Core'
}

{ #category : #tests }
RSCanvasTest >> setUp [
	super setUp.
	c := RSCanvas new.
	
]

{ #category : #tests }
RSCanvasTest >> testNodesShapesAndEdges [
	| n1 n2 n3 eb nodes |
	n1 := RSEllipse new size: 10; model: 1.
	n2 := RSEllipse new size: 10; model: 2.
	n3 := RSEllipse new size: 10; model: 3.
	nodes := Array with: n1 with: n2 with: n3.
	c addAll: nodes.
	eb := RSEdgeBuilder line.
	eb canvas: c.
	eb useAssociations: (Array with: (1 -> 2) with: (2 -> 3) with: (3 -> 1)).
	self assert: c shapes size equals: 6.
	self assert: (c shapes includesAll: nodes).
	
	self assert: c nodes equals: nodes asGroup.
	self assert: c edges size equals: 3.
]
