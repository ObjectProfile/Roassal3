"
I am prepared to sunburst arcs
"
Class {
	#name : #RSSunburstCPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Sunburst'
}

{ #category : #hooks }
RSSunburstCPController >> controlPointsFor: aLine [
	| cp1 cp2 cp3 cp4 from to width1 width2 |
	from := aLine from.
	to := aLine to.
	width1 := (from externalRadius - from innerRadius)/2.
	from innerRadius isZero ifTrue: [ width1 := 0 ].
	cp1 := RSSunburstAttachPoint centroid: from offset: width1 negated.
	cp2 := RSSunburstAttachPoint centroid: from offset: width1.

	width2 := (to externalRadius - to innerRadius)/2.
	cp3 := to centroid: (width1 * 2 + width2) negated.
	cp4 := to centroid: width2 negated.
	^ Array
		with: cp1
		with: cp2
		with: cp3
		with: cp4
]
