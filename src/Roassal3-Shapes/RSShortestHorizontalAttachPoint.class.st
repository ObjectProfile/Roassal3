"
New Control points controller for bezier lines in this visualization
"
Class {
	#name : #RSShortestHorizontalAttachPoint,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #hooks }
RSShortestHorizontalAttachPoint >> controlPointsFor: aLine [
	| r1 r2 ap c1 c2 c3 c4 mid |
	ap := aLine attachPoint.
	r1 := self rectangleFor: aLine from line: aLine.
	r2 := self rectangleFor: aLine to line: aLine.
	c1 := r1 floatCenter.
	c4 := r2 floatCenter.
	c1 x < c4 x  ifTrue: [ 
		c1 := r1 rightCenter.
		c4 := r2 leftCenter.
	] ifFalse: [ 
		c1 := r1 leftCenter.
		c4 := r2 rightCenter.
	].
	mid := (c1 x + c4 x)/2.
	c2 :=	mid @ c1 y.
	c3 := mid @ c4 y.
	^ { c1. c2. c3. c4 }
	
]

{ #category : #hooks }
RSShortestHorizontalAttachPoint >> rectangleFor: shape line: line [
	| r ap |
	ap := line attachPoint.
	r := shape encompassingRectangle.
	^ (ap positionFor: shape in: line point: r origin) 
		corner: (ap positionFor: shape in: line point: r corner).
]
