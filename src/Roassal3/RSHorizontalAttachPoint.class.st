"
Horizontal attach points between elements when drawing lines.  Useful for horizontal tree layout.
"
Class {
	#name : #RSHorizontalAttachPoint,
	#superclass : #RSOffsetAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
RSHorizontalAttachPoint >> basicEndingPointOf: edge [
	^ edge to encompassingRectangle leftCenter + (endOffset@0)
]

{ #category : #'public - hooks' }
RSHorizontalAttachPoint >> basicStartingPointOf: edge [
	^ edge from encompassingRectangle rightCenter + (startOffset@0)
]
