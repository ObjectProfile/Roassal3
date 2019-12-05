"
I am an attach point to build edges
"
Class {
	#name : #RSSunburstAttachPoint,
	#superclass : #RSAttachPoint,
	#category : #'Roassal3-Sunburst'
}

{ #category : #'public - hooks' }
RSSunburstAttachPoint >> basicEndingPointOf: anEdge [
	^ anEdge to centroid: 0
]

{ #category : #'public - hooks' }
RSSunburstAttachPoint >> basicStartingPointOf: anEdge [
	^ anEdge from centroid: 0
]
