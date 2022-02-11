Class {
	#name : #RSdeCasteljauRationalLine,
	#superclass : #RSdeCasteljauLine,
	#instVars : [
		'weights'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalLine >> deCasteljau: diffPoints at: t [

	| aPoint n quo |
	n := diffPoints size.
	aPoint := 0 @ 0.
	quo := 0.

	diffPoints withIndexDo: [ :each :i | 
		| weight bernstein factor |
		weight := weights at: i.
		bernstein := self bernstein: n - 1 choose: i - 1 at: t.
		factor := weight * bernstein.
		quo := quo + factor.
		aPoint := aPoint + (each * factor) ].

	^ { (aPoint / quo) }
]

{ #category : #accessing }
RSdeCasteljauRationalLine >> weights: anObject [

	weights := anObject
]
