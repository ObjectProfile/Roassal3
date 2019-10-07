"
Vertical attach points between elements when drawing lines. Useful for (vertical) tree layout
"
Class {
	#name : #RSVerticalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-Scripting-AttachPoint'
}

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicEndingPointOf: anEdge [
	^ self
		positionFor: anEdge to 
		point: anEdge to encompassingRectangle topCenter + (0@endOffset)
]

{ #category : #'public - hooks' }
RSVerticalAttachPoint >> basicStartingPointOf: anEdge [
	^ self
		positionFor: anEdge from 
		point: anEdge from encompassingRectangle bottomCenter + (0@startOffset)
]
