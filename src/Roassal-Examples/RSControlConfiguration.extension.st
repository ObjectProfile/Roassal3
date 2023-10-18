Extension { #name : 'RSControlConfiguration' }

{ #category : '*Roassal-Examples' }
RSControlConfiguration class >> example1 [
	| c controller |
	c := RSCanvas new.
	controller := RSCanvasController new.
	controller configuration: (self new maxScale: 10).
	c @ controller.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSControlConfiguration class >> example2 [
	| canvas shapes int |
	canvas := RSCanvas new.
	shapes := RSLabel models: #('hello' 'world' 'from' 'Roassal').
	canvas addAll: shapes.
	RSVerticalLineLayout on: shapes.
	int := RSCanvasController new.
	int configuration
		minScale: 1;
		maxScale: 3.
	canvas @ int.
	^ canvas open
]
