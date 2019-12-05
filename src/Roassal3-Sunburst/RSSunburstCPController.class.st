"
I am prepared to sunburst arcs
"
Class {
	#name : #RSSunburstCPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Sunburst'
}

{ #category : #hooks }
RSSunburstCPController >> controlPointsFor: anEdge [
	| cp1 cp2 cp3 cp4 from to width |
	from := anEdge from.
	to := anEdge to.
	cp1 := from centroid: 0.
	cp4 := to centroid: 0.
	"cp2 := cp3 := cp4."
	width := from externalRadius - from innerRadius.
	from innerRadius isZero ifTrue: [ width := 0 ].
	cp2 := from centroid: width / 2.
	width := to externalRadius - to innerRadius.
	cp3 := to centroid: width / -2.
	^ Array
		with: cp1
		with: cp2
		with: cp3
		with: cp4
]
