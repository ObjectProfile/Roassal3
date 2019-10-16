"
Vertical attach points between elements when drawing lines. Useful for (vertical) tree layout
"
Class {
	#name : #TSVerticalAttachPoint,
	#superclass : #TSOffsetAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
TSVerticalAttachPoint >> basicEndingPointOf: anEdge [
	^ self
		positionFor: anEdge to 
		point: anEdge to encompassingRectangle topCenter + (0@endOffset)
]

{ #category : #'public - hooks' }
TSVerticalAttachPoint >> basicStartingPointOf: anEdge [
	^ self
		positionFor: anEdge from 
		point: anEdge from encompassingRectangle bottomCenter + (0@startOffset)
]
