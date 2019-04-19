"
Vertical attach points between elements when drawing lines. Useful for (vertical) tree layout
"
Class {
	#name : #RSVerticalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicEndingPointOf: anEdge [
	^ anEdge to encompassingRectangle topCenter + (0@endOffset)
]

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicStartingPointOf: anEdge [
	^ anEdge from encompassingRectangle bottomCenter + (0@startOffset)
]
