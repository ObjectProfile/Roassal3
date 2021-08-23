Class {
	#name : #RSSimpleForceBasedLayout,
	#superclass : #RSLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSSimpleForceBasedLayout >> doExecute: shapes [
	| layout es |
	shapes do: [ :n | n updateLinesOFF ].
	layout := RSForceBasedLayout new.
	layout nodes: shapes.
	es := shapes flatCollect: #outgoingLines.
	layout edges: es.
	layout start.
	shapes do: [ :node | (layout mockElementAt: node)
		charge: node width * -10;
		weight: node width ].
	es do: [ :edge | (layout mockEdgeAt: edge)
		strength: 1;
		length: (edge from width + edge to width) ].
	layout runLayoutSimply.
	shapes do: [ :n | n updateLinesON. n connectedLines do: #update ].
]
