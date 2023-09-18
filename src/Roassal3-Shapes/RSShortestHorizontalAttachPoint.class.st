"
I am similar to RSHorizontalAttachPoint, with the different that I want to find the shortests distance
"
Class {
	#name : #RSShortestHorizontalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSShortestHorizontalAttachPoint >> basicEndingPointOf: aLine [
	| r1 r2 off p1 p2 center |
	r1 := aLine from globalEncompassingRectangle.
	r2 := aLine to globalEncompassingRectangle.
	off := endOffset@0.
	p1 := r2 rightCenter + off.
	p2 := r2 leftCenter - off.
	center := r1 floatCenter.
	^ (p1 distanceTo: center) < (p2 distanceTo: center)
		ifTrue: [ p1 ]
		ifFalse: [ p2 ]
]

{ #category : #'public - hooks' }
RSShortestHorizontalAttachPoint >> basicStartingPointOf: aLine [
	| r1 r2 off p1 p2 center |
	r1 := aLine from globalEncompassingRectangle.
	r2 := aLine to globalEncompassingRectangle.
	off := startOffset@0.
	p1 := r1 rightCenter + off.
	p2 := r1 leftCenter - off.
	center := r2 floatCenter.
	^ (p1 distanceTo: center) < (p2 distanceTo: center)
		ifTrue: [ p1 ]
		ifFalse: [ p2 ]
]
