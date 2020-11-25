"
A ring shape to draw ring in a circle shape, not in a ellipse.

"
Class {
	#name : #RSPieSlice,
	#superclass : #RSBoundingShape,
	#instVars : [
		'alphaAngle',
		'betaAngle',
		'innerRadius',
		'externalRadius',
		'segmentSpacing',
		'cornerRadii'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #accessing }
RSPieSlice >> alphaAngle [
	^ alphaAngle
]

{ #category : #accessing }
RSPieSlice >> alphaAngle: stAngle [
	"Starting angle"
	| old |
	old := alphaAngle.
	alphaAngle := stAngle.
	old = alphaAngle ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #public }
RSPieSlice >> arcRadiusAuto [
	| e i |
	e := externalRadius.
	i := innerRadius.
	self cornerRadii: ((i * i) + (e * e)) sqrt
]

{ #category : #accessing }
RSPieSlice >> betaAngle [
	^ betaAngle
]

{ #category : #accessing }
RSPieSlice >> betaAngle: ndAngle [
	"Finishing angle"
	| old |
	old := betaAngle.
	betaAngle := ndAngle.
	old = betaAngle ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #visiting }
RSPieSlice >> buildPathOn: visitor [
	visitor buildRingPath: self
]

{ #category : #accessing }
RSPieSlice >> centroid: off [
	| r a |
	r := innerRadius isZero
		ifTrue: [ 0 ]
		ifFalse: [ (innerRadius + externalRadius)/2 ].
	r := r + off.
	a := self middleAngle degreesToRadians.
	^ (a cos @ (a sin negated) * r)  + self position.
]

{ #category : #accessing }
RSPieSlice >> cornerRadii [
	^ cornerRadii
]

{ #category : #accessing }
RSPieSlice >> cornerRadii: aNumber [
	| old |
	self 
		assert: [ aNumber >= 0 ]
		description: 'Corner radius must be a non-negative!'.
	old := cornerRadii.
	cornerRadii := aNumber.
	old = cornerRadii ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #utilities }
RSPieSlice >> emphasizeWith: anInteger [ 
	self translateBy: (self centroid: anInteger)
]

{ #category : #accessing }
RSPieSlice >> extent: aPoint [
	super extent: aPoint.
	externalRadius := (aPoint x min: aPoint y)/2.
]

{ #category : #accessing }
RSPieSlice >> externalRadius [
	^ externalRadius
]

{ #category : #accessing }
RSPieSlice >> externalRadius: eR [
	self extent: (eR * 2) asPoint.
]

{ #category : #testing }
RSPieSlice >> includesPoint: aPoint [
	| invertedPoint a b i e n d |
	invertedPoint := matrix rsInverseTransform: aPoint.
	(self baseRectangle containsPoint: invertedPoint)
		ifFalse: [ ^ false ].
	i := innerRadius.
	e := externalRadius.
	d := invertedPoint dist: 0 @ 0.
	(d between: i and: e)
		ifFalse: [ ^ false ].
	n := invertedPoint angle negated radiansToDegrees.
	a := alphaAngle.
	b := betaAngle.
	n := (360 + (n % 360)) % 360.
	a := (3600000 + a) % 360.
	b := (3600000 + b) % 360.
	^ a < b
		ifTrue: [ n between: a and: b ]
		ifFalse: [ a <= n | (n <= b) ]
]

{ #category : #initialization }
RSPieSlice >> initialize [
	super initialize.
	cornerRadii := innerRadius := externalRadius := betaAngle := alphaAngle := segmentSpacing := 0.
	
]

{ #category : #accessing }
RSPieSlice >> innerRadius [
	^ innerRadius
]

{ #category : #accessing }
RSPieSlice >> innerRadius: iR [
	| old |
	old := innerRadius.
	innerRadius := iR asFloat.
	old = innerRadius ifTrue: [ ^ self ].
	self resetPath.
]

{ #category : #accessing }
RSPieSlice >> middleAngle [
	^ (alphaAngle + betaAngle) / 2
]

{ #category : #accessing }
RSPieSlice >> segmentSpacing [
	^ segmentSpacing
]

{ #category : #accessing }
RSPieSlice >> segmentSpacing: anAngleInDegrees [
	| old |
	old := segmentSpacing.
	segmentSpacing := anAngleInDegrees.
	old = segmentSpacing ifTrue: [ ^self ].
	self resetPath.
]

{ #category : #accessing }
RSPieSlice >> shiftAngles: aNumber [ 
	self 
		alphaAngle: alphaAngle + aNumber;
		betaAngle: betaAngle + aNumber
	
]
