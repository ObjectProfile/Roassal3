"
I am similar to RSVerticalAttachPoint, but I find the shortest line between each shape bounding box.
"
Class {
	#name : 'RSShortestVerticalAttachPoint',
	#superclass : 'RSOffsetAttachPoint',
	#category : 'Roassal-Shapes-AttachPoint',
	#package : 'Roassal-Shapes',
	#tag : 'AttachPoint'
}

{ #category : 'public - hooks' }
RSShortestVerticalAttachPoint >> basicEndingPointOf: aLine [
	| r1 r2 off p1 p2 center |
	r1 := aLine from globalEncompassingRectangle.
	r2 := aLine to globalEncompassingRectangle.
	off := 0@endOffset.
	p1 := r2 topCenter - off.
	p2 := r2 bottomCenter + off.
	center := r1 floatCenter.
	^ (p1 distanceTo: center) < (p2 distanceTo: center)
		ifTrue: [ p1 ]
		ifFalse: [ p2 ]
]

{ #category : 'public - hooks' }
RSShortestVerticalAttachPoint >> basicStartingPointOf: aLine [
	| r1 r2 off p1 p2 center |
	r1 := aLine from globalEncompassingRectangle.
	r2 := aLine to globalEncompassingRectangle.
	off := 0@startOffset.
	p1 := r1 topCenter - off.
	p2 := r1 bottomCenter + off.
	center := r2 floatCenter.
	^ (p1 distanceTo: center) < (p2 distanceTo: center)
		ifTrue: [ p1 ]
		ifFalse: [ p2 ]
]
