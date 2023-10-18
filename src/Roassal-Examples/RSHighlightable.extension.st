Extension { #name : 'RSHighlightable' }

{ #category : '*Roassal-Examples' }
RSHighlightable class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas nodes @ self blue.
	^ canvas open
		setLabel: 'Move mouse over shapes';
		yourself
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleBorder [
	| c shapes interaction |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSBox new border: (RSBorder new color: Color red; width: 3); model: v ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup.

	RSNormalizer size
		shapes: shapes;
		normalize: #yourself.

	interaction := self new.
	interaction highlightColor: Color blue.
	interaction highlightBorder: (RSBorder new color: Color black; width: 3).
	shapes @ interaction.

	RSGridLayout on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleGrid [
	| c shapes interaction |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup.

	interaction := self new.
	interaction highlightBorder: (RSBorder new width: 3; color: Color pink).
	shapes @ interaction.

	RSGridLayout on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleGrid2 [
	| c shapes interaction |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup.

	interaction := self new.
	interaction highlightBorder: (RSBorder new width: 3; color: Color pink).
	shapes @ interaction.

	RSGridLayout on: shapes.
	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleInteractive [

	| classes c shapes buttonReset selectedShapes highlightable lbl buttonInspect g |
	classes := Collection withAllSubclasses.

	c := RSCanvas new.
	selectedShapes := RSGroup new.
	highlightable := self new.
	lbl := RSLabel new.
	shapes := classes
		          collect: [ :cls | RSBox new model: cls ]
		          as: RSGroup.

	c addAll: shapes.
	RSNormalizer size
		shapes: shapes;
		normalize: #numberOfMethods.
	RSFlowLayout on: shapes.

	shapes @ RSPopup.

	buttonReset := RSLabel text: 'Reset'.
	c add: buttonReset.
	buttonReset setAsFixed.
	buttonReset @ self red.
	buttonReset
		when: RSMouseClick
		do: [ :evt |
			selectedShapes do: [ :s |
				highlightable restore: s selector: #color ].
			selectedShapes := RSGroup new.
			lbl text: ''.
			c signalUpdate ]
		for: self.

	buttonInspect := RSLabel text: 'Inspect'.
	c add: buttonInspect.
	buttonInspect setAsFixed.
	buttonInspect @ self red.
	buttonInspect
		when: RSMouseClick
		do: [ :evt | selectedShapes inspect ]
		for: self.
	c add: lbl.
	lbl setAsFixed.
	lbl translateTo: 90 @ 30.

	g := {
		     buttonReset.
		     buttonInspect } asGroup.
	RSHorizontalLineLayout on: g.
	g translateTo: g extent / 2 + (10 @ 10).

	shapes
		when: RSMouseClick
		do: [ :evt |
			(selectedShapes includes: evt shape) ifFalse: [
				selectedShapes add: evt shape ].
			highlightable record: evt shape selector: #color value: Color red.
			lbl text: selectedShapes size asString , ' selected shapes'.
			c signalUpdate ]
		for: self.

	c @ RSCanvasController.
	^ c openOnce
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleNumbers [
	| c shapes lb int |
	c := RSCanvas new.

	shapes := (1 to: 10) collect: [ :v | RSEllipse new size: 20; model: v ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup new; @ RSDraggable new.

	RSCircleLayout on: shapes.

	lb := RSLineBuilder arrowedLineWithOffset: 0.5.
	lb canvas: c.
	lb connectTo: [ :v | 1 ].

	int := self new withEdges highlightColor: Color red.
	shapes @ int.

	c @ RSCanvasController.
	^ c open
]

{ #category : '*Roassal-Examples' }
RSHighlightable class >> exampleTree [
	| c shapes interaction |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSEllipse new  model: v; size: 10 ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup.

	RSEdgeBuilder line
		canvas: c;
		withBorderAttachPoint;
		connectFrom: [ :v | v // 2 ].

	interaction := self new.
	interaction highlightBorder: (RSBorder new color: Color black; width: 3).
	interaction withEdges.
	shapes @ interaction.

	RSTreeLayout on: shapes.
	c @ RSCanvasController.
	^ c open
]
