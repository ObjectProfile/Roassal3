Extension { #name : 'RSLabeled' }

{ #category : '*Roassal-Examples' }
RSLabeled class >> exampleBoxes [
	| c shapes |
	c := RSCanvas new.

	shapes := RSGroup new.
	1 to: 3 do: [ :v |
		shapes add: (RSBox new model: v) ].

	shapes @ (self new text: [ :m | 'Value = ', m asString ]).

	RSNormalizer size
		shapes: shapes;
		from: 20; to: 40;
		normalize: [ :aModel | aModel ].

	c addAll: shapes.
	RSVerticalLineLayout new gapSize: 30; on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSLabeled class >> exampleLabeledHighlightable [
	| c shapes |
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :v | RSBox new model: v; size: 30 ] as: RSGroup.
	c addAll: shapes.
	shapes @ self new highlightable.
	RSNormalizer size shapes: shapes; normalize: #yourself.
	RSGridLayout on: shapes.
	c @ RSCanvasController.
	^ c open
]
