"
Horizontal attach points between elements when drawing lines.  Useful for horizontal tree layout.
"
Class {
	#name : #TSHorizontalAttachPoint,
	#superclass : #TSOffsetAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
TSHorizontalAttachPoint >> basicEndingPointOf: edge [
	^ self
		positionFor: edge to
		point: edge to encompassingRectangle leftCenter + (endOffset@0)
]

{ #category : #'public - hooks' }
TSHorizontalAttachPoint >> basicStartingPointOf: edge [
	^ self
		positionFor: edge from 
		point: edge from encompassingRectangle rightCenter + (startOffset@0)
]
