"
New Control points controller for bezier lines in this visualization
"
Class {
	#name : #RSShortestHorizontalCPController,
	#superclass : #RSAbstractCPController,
	#instVars : [
		'startOffset',
		'endOffset'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #hooks }
RSShortestHorizontalCPController >> controlPointsFor: aLine [
	| r1 r2 ap c1 c2 c3 c4 mid off1 off2 |
	ap := aLine attachPoint.
	r1 := self rectangleFor: aLine from line: aLine.
	r2 := self rectangleFor: aLine to line: aLine.
	c1 := r1 floatCenter.
	c4 := r2 floatCenter.
	off1 := startOffset @ 0.
	off2 := endOffset @ 0.
	c1 x < c4 x  ifTrue: [
		c1 := r1 rightCenter + off1.
		c4 := r2 leftCenter - off2.
	] ifFalse: [
		c1 := r1 leftCenter - off1.
		c4 := r2 rightCenter + off2.
	].
	mid := (c1 x + c4 x)/2.
	c2 :=	mid @ c1 y.
	c3 := mid @ c4 y.
	^ { c1. c2. c3. c4 }
]

{ #category : #accessing }
RSShortestHorizontalCPController >> endOffset [
	^ endOffset
]

{ #category : #accessing }
RSShortestHorizontalCPController >> endOffset: aNumber [
	endOffset := aNumber
]

{ #category : #initialization }
RSShortestHorizontalCPController >> initialize [
	super initialize.
	startOffset := endOffset := 0
]

{ #category : #hooks }
RSShortestHorizontalCPController >> rectangleFor: shape line: line [
	| r ap |
	ap := line attachPoint.
	r := shape encompassingRectangle.
	^ (ap positionFor: shape in: line point: r origin)
		corner: (ap positionFor: shape in: line point: r corner)
]

{ #category : #accessing }
RSShortestHorizontalCPController >> startOffset [
	^ startOffset
]

{ #category : #accessing }
RSShortestHorizontalCPController >> startOffset: aNumber [
	startOffset := aNumber
]
