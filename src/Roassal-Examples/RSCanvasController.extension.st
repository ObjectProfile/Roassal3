Extension { #name : 'RSCanvasController' }

{ #category : '*Roassal-Examples' }
RSCanvasController class >> exampleNoLegend [
	| canvas int |
	canvas := RSCanvas new.
	int := self new.
	int noLegend.
	canvas addAll: (RSLabel models: ('Nessun dorma! Nessun dorma! Tu pure, oh Principessa' splitOn: ' ')).
	RSVerticalLineLayout on: canvas nodes.
	canvas addInteraction: int.
	^ canvas open
]
