Extension { #name : #RSSearchInCanvasInteraction }

{ #category : #'*Roassal3-Examples' }
RSSearchInCanvasInteraction class >> exampleCollection [
	| c shapes lb |
	c := RSCanvas new.
	shapes := Collection withAllSubclasses
		collect: [ :n | RSEllipse new size: 20; model: n ]
		as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup.
	lb := RSLineBuilder line.
	lb canvas: c.
	lb connectFrom: #superclass.
	RSTreeLayout on: shapes.
	c @ RSCanvasController.
	^ c open
		setLabel: 'Press `s` to start the search';
		yourself
]

{ #category : #'*Roassal3-Examples' }
RSSearchInCanvasInteraction class >> exampleCollection2 [

	| c classes g elements high con search |
	c := RSCanvas new.

	classes := Collection withAllSubclasses.
	elements := classes collect: [ :cls |
		g := RSGroup new
			add: (RSLabel new text: cls name);
			add: (RSEllipse new size: (cls numberOfMethods + 5) sqrt; color: Color blue );
			yourself.
		RSVerticalLineLayout new alignCenter; on: g.
		g asShapeFor: cls ] as: RSGroup.

	c addAll: elements.
	high := RSHighlightable red.
	elements @ high.
	RSGridLayout new
		lineItemsCount: 5;
		on: elements.

	con := RSCanvasController new.
	con addInteraction: (search := self new
		colorToHighlight: Color blue translucent;
		yourself).

	c @ con.
	^ c open
		setLabel: 'Press `s` to start the search';
		yourself
]
