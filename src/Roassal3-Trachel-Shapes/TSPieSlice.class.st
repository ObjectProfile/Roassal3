"
A ring shape to draw ring in a circle shape, not in a ellipse.

"
Class {
	#name : #TSPieSlice,
	#superclass : #TSBoundingShape,
	#instVars : [
		'alphaAngle',
		'betaAngle',
		'innerRadius',
		'externalRadius',
		'segmentSpacing',
		'cornerRadii'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSPieSlice >> alphaAngle [
	^ alphaAngle
]

{ #category : #accessing }
TSPieSlice >> alphaAngle: stAngle [
	| old |
	old := alphaAngle.
	alphaAngle := stAngle.
	old = alphaAngle ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #public }
TSPieSlice >> arcRadiusAuto [
	| e i |
	e := externalRadius .
	i := innerRadius.
	self cornerRadii: ((i * i) + (e * e)) sqrt
]

{ #category : #accessing }
TSPieSlice >> betaAngle [
	^ betaAngle
]

{ #category : #accessing }
TSPieSlice >> betaAngle: ndAngle [
	| old |
	old := betaAngle.
	betaAngle := ndAngle.
	old = betaAngle ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #visiting }
TSPieSlice >> buildPathOn: visitor [
	visitor buildRingPath: self
]

{ #category : #accessing }
TSPieSlice >> centroid: off [
	| r a |
	r := (innerRadius + externalRadius)/2 + off.
	a := ((alphaAngle + betaAngle) / 2) degreesToRadians.
	^ (a cos @ (a sin negated) * r)  + externalRadius.
]

{ #category : #accessing }
TSPieSlice >> cornerRadii [
	^ cornerRadii
]

{ #category : #accessing }
TSPieSlice >> cornerRadii: aNumber [
	| old |
	self 
		assert: [ aNumber >= 0 ]
		description: 'Corner radius must be a non-negative!'.
	old := cornerRadii.
	cornerRadii := aNumber.
	old = cornerRadii ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #accessing }
TSPieSlice >> extent: aPoint [
	super extent: aPoint.
	externalRadius := (aPoint x min: aPoint y)/2.
]

{ #category : #accessing }
TSPieSlice >> externalRadius [
	^ externalRadius
]

{ #category : #accessing }
TSPieSlice >> externalRadius: eR [
	self extent: (eR * 2) asPoint.
]

{ #category : #initialization }
TSPieSlice >> initialize [
	super initialize.
	cornerRadii := innerRadius := externalRadius := betaAngle := alphaAngle := segmentSpacing := 0.
	
]

{ #category : #accessing }
TSPieSlice >> innerRadius [
	^ innerRadius
]

{ #category : #accessing }
TSPieSlice >> innerRadius: iR [
	| old |
	old := innerRadius.
	innerRadius := iR asFloat.
	old = innerRadius ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #accessing }
TSPieSlice >> segmentSpacing [
	^ segmentSpacing
]

{ #category : #accessing }
TSPieSlice >> segmentSpacing: anAngleInDegrees [
	| old |
	old := segmentSpacing.
	segmentSpacing := anAngleInDegrees.
	old = segmentSpacing ifTrue: [ ^self ].
	self resetPath.
]
