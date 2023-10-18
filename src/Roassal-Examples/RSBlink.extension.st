Extension { #name : 'RSBlink' }

{ #category : '*Roassal-Examples' }
RSBlink class >> example [

	| canvas shapes |
	canvas := RSCanvas new.
	shapes := RSCircle models: (1 to: 9).
	shapes size: 30.
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	shapes when: RSMouseClick do: [ :evt | evt shape @ self ] for: self.

	shapes fifth @ self.
	canvas zoomToFit.
	^ canvas open
		  setLabel: 'Click one ellipse';
		  yourself
]
