"
`RSLayout` is an abstract class which represents a layout made to set the position of a group of shapes.

Layouts perform once on a group of shapes, if you want to apply a relayout, you have to call again the layout.
You can use the layout creating a new instance of it.
```st
layout := RSGridLayout new.
layout on: shapes.
```
Or using the class method `RSLayout class >> #on:`

```st
RSGridLayout on: shapes
```
My instance variable is
- translator, an `RSLayoutTranslator` to set the position based on the bounding box of each shape.

I collaborate with
- `RSBoundingShape` to get the shape position.
- `RSAbstractLine` to get the relation between two bounding shapes.

I provide the following methods.

- `RSLayout >> #on:`, a shortcut to call `applyOn:`
- `RSLayout >> #on:edges:`, similar to on, but using custom links/edges/lines.
- `RSLayout >> #userDefinedEdges:`, to set the nodes links/edges/lines for the layout.
- `RSLayout >> #applyOn:`, a shortcut to call `executeOnElements:`
- `RSLayout >> #executeOnElements:`, to initialize and call the execution of the layout
- `RSLayout >> #doInitialize:`, override this method to initialize the layout with a group of shapes.
- `RSLayout >> #doExecute:`, override this method and set the position of each element here.
- `RSLayout >> #doPost:`, orerride this method to finalize the the layout process.

"
Class {
	#name : #RSLayout,
	#superclass : #RSObject,
	#instVars : [
		'translator'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #documentation }
RSLayout class >> addDocumentSection: aBuilder label: label methods: methods [

	methods ifEmpty: [ ^ self ].

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: label ] withLevel: 2.
	aBuilder unorderedListDuring: [
		(methods sorted: #selector ascending) do: [ :each |
			aBuilder item: [
				aBuilder monospace: (each methodClass name, '>>#', each selector) ] ] ]
]

{ #category : #documentation }
RSLayout class >> addDocumentSectionHierarchy: aBuilder [

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Hierarchy' ] withLevel: 2.
	SpDocumentHierarchyBuilder new
		fromClass: RSLayout;
		builder: aBuilder;
		filter: [ :eachClass | eachClass package packageName beginsWith: 'Roassal3-' ];
		buildFor: self
]

{ #category : #examples }
RSLayout class >> basicExample [
	| canvas |
	canvas := self canvasExample.
	self on: canvas nodes.
	^ canvas open
]

{ #category : #documentation }
RSLayout class >> buildMicroDownUsing: aBuilder withComment: aString [
	super buildMicroDownUsing: aBuilder withComment: aString.
	self documentSections keysAndValuesDo: [ :label :methods |
		self addDocumentSection: aBuilder label: label methods: methods ].
	self addDocumentSectionHierarchy: aBuilder
]

{ #category : #examples }
RSLayout class >> canvasExample [
	| canvas |
	canvas := RSCanvas new.
	self canvasExampleIn: canvas.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSLayout class >> canvasExampleIn: canvas [
	| shapes colorPalette |
	self cartensianLinesIn: canvas.
	shapes := RSBox models: Collection withAllSubclasses.
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

{ #category : #examples }
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

{ #category : #documentation }
RSLayout class >> documentSections [
	^ OrderedDictionary newFromPairs: {
		'Examples'. self class methods select: [ :each | each selector beginsWith: 'example' ].
		}
]

{ #category : #testing }
RSLayout class >> isAbstract [
	^ self name = #RSLayout
]

{ #category : #public }
RSLayout class >> on: aCollection [
	"main entry point of the class"

	"If aCollection is empty, then there is not much to do"
	aCollection isEmpty ifTrue: [ ^ aCollection ].
	self new applyOn: aCollection.
	^ aCollection
]

{ #category : #public }
RSLayout class >> on: elements edges: edges [
	"To make all the layout polymorphic"

	^ self on: elements
]

{ #category : #hook }
RSLayout >> applyOn: elements [
	"Return quickly if there is nothing to do"
	elements isEmpty ifTrue: [ ^ self ].
	self executeOnElements: elements
]

{ #category : #hook }
RSLayout >> doExecute: shapes [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
RSLayout >> doInitialize: elements [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
	"self announce: (ROLayoutBegin new elements: elements)."
]

{ #category : #hook }
RSLayout >> doPost: elements [
	"Method executed after performing the layout"
]

{ #category : #hook }
RSLayout >> executeOnElements: elements [
	"Execute the layout, myself, on the elements"

	self doInitialize: elements.
	self doExecute: elements asOrderedCollection.
	self doPost: elements
]

{ #category : #initialization }
RSLayout >> initialize [
	super initialize.
	translator := RSLayoutTranslator default
]

{ #category : #testing }
RSLayout >> isLineDrivenLayout [
	^ false
]

{ #category : #hook }
RSLayout >> on: elements [
	self applyOn: elements
]

{ #category : #hook }
RSLayout >> on: elements edges: edges [
	self applyOn: elements
]

{ #category : #hook }
RSLayout >> step [
	"use this method for animations"
]

{ #category : #accessing }
RSLayout >> translator [
	^ translator
]

{ #category : #accessing }
RSLayout >> translator: aTranslator [
	translator := aTranslator
]

{ #category : #hook }
RSLayout >> userDefinedEdges: edges [
	"Do nothing"
]
