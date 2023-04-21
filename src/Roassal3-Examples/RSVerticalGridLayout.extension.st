Extension { #name : #RSVerticalGridLayout }

{ #category : #'*Roassal3-Examples' }
RSVerticalGridLayout class >> example1 [
	| c shapes |
	c := RSCanvas new.

	shapes := RSLabel models: (1 to: 9).
	c addAll: shapes.
	self on: shapes.
	c @ RSCanvasController.
	^ c open
]
