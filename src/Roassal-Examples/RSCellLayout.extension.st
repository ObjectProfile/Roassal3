Extension { #name : 'RSCellLayout' }

{ #category : '*Roassal-Examples' }
RSCellLayout class >> example1 [
	| c shapes |
	c := RSCanvas new.

	shapes := RSLabel models: (3 to: 11).
	c addAll: shapes.
	self on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSCellLayout class >> example2 [
	| c shapes |
	c := RSCanvas new.
	"each component has different extent. But each line of the layout contains 10 shapes maximun"
	shapes := RSComposite
		boxesForModels: SequenceableCollection withAllSubclasses.
	c addAll: shapes.
	self new
		lineItemsCount: 5;
		on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSCellLayout class >> example3 [
	| c shapes |
	c := RSCanvas new.
	"each component has different extent. But each line of the layout contains 10 shapes maximun"
	shapes := RSComposite
		boxesForModels: ((1 to: 9) collect: [:i | 'X']).
	c addAll: shapes.
	self new
		lineItemsCount: 3;
		horizontalGap: 2;
		verticalGap: 10;
		on: shapes.
	c @ RSCanvasController.
	^ c open
]
