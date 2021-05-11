Class {
	#name : #RSHorizontalEndBorderAttachPoint,
	#superclass : #RSBorderAttachPoint,
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #'public - hooks' }
RSHorizontalEndBorderAttachPoint >> basicEndingPointOf: edge [

	^ self
		  positionFor: edge to
		  in: edge
		  point: edge to encompassingRectangle leftCenter + (endOffset @ 0)
]
