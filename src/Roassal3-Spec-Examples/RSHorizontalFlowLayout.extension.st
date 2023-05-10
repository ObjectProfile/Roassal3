Extension { #name : #RSHorizontalFlowLayout }

{ #category : #'*Roassal3-Spec-Examples' }
RSHorizontalFlowLayout class >> alignmentOptions [
	^ #(center left right)
]

{ #category : #'*Roassal3-Spec-Examples' }
RSHorizontalFlowLayout class >> exampleLabel [
	
	| string characterShapes c |
	string := 'KISSItemSameStar'.
	characterShapes := RSLabel models: string.

	c := RSCanvas new.
	c addAll: characterShapes.
	
	self new maxWidth: characterShapes first height * 4; alignCenter; gapSize: 0; on: characterShapes.
	
	c @ RSCanvasController.
	c showEncompassingRectangles.
	^ c open
]
