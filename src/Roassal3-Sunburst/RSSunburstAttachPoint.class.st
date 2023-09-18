"
I am an attach point to build edges
"
Class {
	#name : #RSSunburstAttachPoint,
	#superclass : #RSAttachPoint,
	#category : #'Roassal3-Sunburst'
}

{ #category : #'public - hooks' }
RSSunburstAttachPoint class >> centroid: aRSPieSlice [
	^ self centroid: aRSPieSlice offset: 0
]

{ #category : #public }
RSSunburstAttachPoint class >> centroid: aRSPieSlice offset: anInteger [
	| radius angle |
	radius := aRSPieSlice innerRadius isZero
		ifTrue: [ 0 ]
		ifFalse: [ aRSPieSlice middleRadius ].
	radius := radius + anInteger.
	angle := aRSPieSlice middleAngle degreesToRadians.
	^ (angle cos @ (angle sin negated) * radius) + aRSPieSlice position
]

{ #category : #'public - hooks' }
RSSunburstAttachPoint >> basicEndingPointOf: anEdge [
	^ self class centroid: anEdge to
]

{ #category : #'public - hooks' }
RSSunburstAttachPoint >> basicStartingPointOf: aLine [
	^ self class centroid: aLine from
]
