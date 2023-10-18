Extension { #name : 'RSVerticalCellLayout' }

{ #category : '*Roassal-Examples' }
RSVerticalCellLayout class >> example1 [
	| c shapes |
	c := RSCanvas new.

	shapes := RSLabel models: (1 to: 9).
	c addAll: shapes.
	self on: shapes.
	c @ RSCanvasController.
	^ c open
]
