"
TODO
"
Class {
	#name : #RSForceLayoutInSpaces,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'numberOfSpaces',
		'spaces',
		'colorForLinesInSameSpace',
		'colorForLinesInDifferentSpace',
		'linearScale',
		'colorScale',
		'classes'
	],
	#category : #'Roassal3-Layouts-Builder'
}

{ #category : #hooks }
RSForceLayoutInSpaces >> abandonLayout: shape [
	| layout |
	layout := shape propertyAt: #layout.
	shape connectedEdges do: [ :ed | layout removeEdge: ed ].
	layout removeNode: shape
	
]

{ #category : #hooks }
RSForceLayoutInSpaces >> addEdgesOf: shape to: space [
	| layout edgesToAdd |
	layout := space propertyAt: #layout.
	edgesToAdd := shape connectedEdges groupedBy: [ :ed | 
		(ed from propertyAt: #layout) = layout and: [ 
		(ed to propertyAt: #layout) = layout ] ].

	"Edges in the same space"
	(edgesToAdd at: true ifAbsent: [#()]) do: [ :each |
		each color: colorForLinesInSameSpace ].
	
	"Edges in different spaces"
	(edgesToAdd at: false ifAbsent: [#()]) do: [ :each |
		each color: colorForLinesInDifferentSpace ].

	layout addEdges: (edgesToAdd at: true ifAbsent: [#()]).

]

{ #category : #hooks }
RSForceLayoutInSpaces >> addShape: shape to: space [
	| layout |
	layout := space propertyAt: #layout.
	layout addNodes: { shape }.
	shape removeInteractionIfPresent: RSDraggableForce.
	shape addInteraction: (RSDraggableForce new layout: layout).
	shape propertyAt: #layout put: layout.
	
]

{ #category : #accessing }
RSForceLayoutInSpaces >> classes: aCollection [ 
	classes := aCollection
]

{ #category : #hooks }
RSForceLayoutInSpaces >> dragEnd: evt [
	| dropPosition droppedShape targetLayout layout shapesToMove |
	droppedShape := evt shape.
	dropPosition := droppedShape position.
	layout := droppedShape propertyAt: #layout.

	"Find if it was dropped in a space"
	targetLayout := spaces
		detect: [ :s | s includesPoint: dropPosition ]
		ifNone: [ ^ self ].

	"Check if it's a different space"
	(targetLayout propertyAt: #layout) = layout ifTrue: [ ^ self ].

	"Move shape and company"	
	shapesToMove := self withShapesThatAccompany: droppedShape.
	shapesToMove do: [ :s | self abandonLayout: s ].
	shapesToMove do: [ :s | self addShape: s to: targetLayout ].
	shapesToMove do: [ :s | self addEdgesOf: s to: targetLayout ].

]

{ #category : #hooks }
RSForceLayoutInSpaces >> fill: space with: aCollection [
	| layout cpController |
	cpController := RSBlockCPController new
		block: [ :edge |
			| result a b |
			a := edge from position.
			b := edge to position.
			
			result := OrderedCollection with: a with: b.
			(edge from propertyAt: #layout) = (edge to propertyAt: #layout) ifFalse: [
				| vector u d unit middle left right |
				vector := a - b.
				u := vector normal.
				d := a distanceTo: b.
				unit := vector / (vector r max: 1).
				middle := b + (unit * d / 2).
				left := middle - (u * d * 0.15).
				right := middle + (u * d * 0.15).
				result add: ({ left. right } detectMax: #y) afterIndex: 1 ].
			result ];
		yourself.
		
	RSLineBuilder bezier
		controlPointsController: cpController;
		canvas: self canvas;
		color: colorForLinesInSameSpace;
		shapes: aCollection;
		connectFrom: #superclass to: #yourself.
	self canvas addAll: aCollection.
	layout := (space propertyAt: #layout)
		nodes: aCollection;
		edges: self canvas edges;
		start.
	aCollection do: [ :s | s propertyAt: #layout put: layout ].
	aCollection @ (RSDraggableForce new layout: layout).
	aCollection do:[ :s | s when: RSMouseDragEnd send: #dragEnd: to: self ]

]

{ #category : #initialization }
RSForceLayoutInSpaces >> initialize [
	super initialize.
	colorForLinesInSameSpace := Color blue muchDarker alpha: 0.8.
	colorForLinesInDifferentSpace := Color blue muchDarker alpha: 0.1.
	colorScale := NSScale category20.
	linearScale := NSScale linear domain: #(5 20); range: #(5 10).
]

{ #category : #shapes }
RSForceLayoutInSpaces >> newShapeFor: aClass [
	^ RSEllipse new
		popup;
		model: aClass;
		color: (colorScale scale: aClass package name);
		size: (linearScale scale: aClass asString size);
		yourself
]

{ #category : #shapes }
RSForceLayoutInSpaces >> newSpaceFor: model [
	| space layout |
	layout := RSRectangleForceLayout new
		start;
		yourself.
	space := RSBox new
		noPaint;
		model: model;
		extent: 400@400;
		border: (RSBorder new color: (colorScale scale: model); width: 2; dashArray: #(10); yourself);
		propertyAt: #layout put: layout;
		yourself.
	self canvas newAnimation repeat onStepDo: [ :t | layout step. ].
	^ space
]

{ #category : #accessing }
RSForceLayoutInSpaces >> numberOfSpaces [
	^ numberOfSpaces
]

{ #category : #accessing }
RSForceLayoutInSpaces >> numberOfSpaces: anInteger [ 
	numberOfSpaces := anInteger
]

{ #category : #hooks }
RSForceLayoutInSpaces >> renderIn: aCanvas [
	spaces := (1 to: numberOfSpaces) collect: [ :i | self newSpaceFor: i ].
	shapes := classes collect: [ :obj | self newShapeFor: obj ] as: RSGroup.
	self fill: spaces first with: shapes.
	aCanvas addAll: spaces.
	(RSGridLayout withGap: 20) on: spaces.
	spaces do: [ :space | self updateSpace: space. ].
	aCanvas @ RSSimpleCanvasMonitor.
	aCanvas @ RSCanvasController.
]

{ #category : #hooks }
RSForceLayoutInSpaces >> updateSpace: space [
	| layout |
	layout := space propertyAt: #layout.
	layout center: space position.
	layout enclosingRectangle: space encompassingRectangle
]

{ #category : #hooks }
RSForceLayoutInSpaces >> withShapesThatAccompany: shape [
	^ shape model withAllSubclasses collect: [ :cls | self canvas shapeFromModel: cls ].
]
