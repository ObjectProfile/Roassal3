Extension { #name : #RSLayout }

{ #category : #'*Roassal-Class-Examples' }
RSLayout class >> basicExample [
	| canvas |
	canvas := self canvasExample.
	self on: canvas nodes.
	^ canvas open
]

{ #category : #'*Roassal-Class-Examples' }
RSLayout class >> canvasExample [
	| canvas |
	canvas := RSCanvas new.
	self canvasExampleIn: canvas.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal-Class-Examples' }
RSLayout class >> canvasExampleIn: canvas [
	self canvasExampleIn: canvas models: Collection withAllSubclasses
]

{ #category : #'*Roassal-Class-Examples' }
RSLayout class >> canvasExampleIn: canvas models: aCollection [
	| shapes colorPalette |
	self cartensianLinesIn: canvas.
	shapes := RSBox models: aCollection.
	canvas addAll: shapes.
	colorPalette := NSScale category20c.
	shapes do: [ :shape |
		shape color: (colorPalette scale: shape model)
		].
	shapes
		@ RSPopup new;
		@ RSDraggable new.
	RSLineBuilder arrowedLine
		shapes: shapes;
		withBorderAttachPoint;
		connectFrom: #superclass.
	RSNormalizer size
		shapes: shapes;
		normalize: #linesOfCode
]

{ #category : #'*Roassal-Class-Examples' }
RSLayout class >> cartensianLinesIn: canvas [
	| lineX lineY zeroLabel |
	lineX := RSArrowedLine new
		color: Color black;
		startPoint: 0@0;
		endPoint: 300@0;
		yourself.
	lineY := lineX copy
		startPoint: 0@0;
		endPoint: 0 @ 300;
		yourself.
	zeroLabel := RSLabel new
		text: '0@0';
		addInteraction: (RSPopup themeText: 'Origin in a box of 300@300');
		position: 0@0;
		color: Color black;
		yourself.
	canvas
		addShape: lineX;
		addShape: lineY;
		addShape: zeroLabel
]
