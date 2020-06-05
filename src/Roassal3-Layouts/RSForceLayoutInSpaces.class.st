"
TODO
"
Class {
	#name : #RSForceLayoutInSpaces,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'numberOfSpaces',
		'objects',
		'color',
		'spaces'
	],
	#category : #'Roassal3-Layouts-Builder'
}

{ #category : #hooks }
RSForceLayoutInSpaces >> add: shape inSpace: space [
	| layout edgesToAdd |
	layout := space propertyAt: #layout.
	layout addNodes: { shape }.
	edgesToAdd := shape connectedEdges select: [ :ed | 
		(ed from propertyAt: #layout) = layout and: [ 
		(ed to propertyAt: #layout) = layout ] ].
	layout addEdges: edgesToAdd.
	shape removeInteractionIfPresent: RSDraggableForce.
	shape @ (RSDraggableForce new layout: layout).
	shape propertyAt: #layout put: layout.
	
]

{ #category : #shapes }
RSForceLayoutInSpaces >> boxFor: obj [
	^ RSBox new
		model: obj;
		color: (color scale: obj);
		size: 10;
		yourself
]

{ #category : #hooks }
RSForceLayoutInSpaces >> connectedShapesFrom: shape [
	^ shape model withAllSubclasses collect: [ :cls | self canvas shapeFromModel: cls ].
]

{ #category : #shapes }
RSForceLayoutInSpaces >> createSpaceFor: model [
	| space layout |
	layout := RSRectangleForceLayout new
		start;
		yourself.
	space := RSBox new
		noPaint;
		model: model;
		extent: 400@400;
		withBorder;
		propertyAt: #layout put: layout;
		yourself.
	space when: RSMouseClick do: [ layout inspect ].
	self canvas newAnimation repeat onStepDo: [ :t | layout step. ].
	^ space
]

{ #category : #hooks }
RSForceLayoutInSpaces >> dragEnd: evt [
	| pos shape target layout allShapes |
	
	shape := evt shape.
	pos := shape position.
	layout := shape propertyAt: #layout.
	target := spaces detect: [ :s | s includesPoint: pos ] ifNone: [ ^ self ].
	
	(target propertyAt: #layout) = layout ifTrue: [ ^ self ].
	
	allShapes := self connectedShapesFrom: shape.
	allShapes do: [ :s | self remove: s. ].
	allShapes do: [ :s |self add: s inSpace: target ]
	
]

{ #category : #hooks }
RSForceLayoutInSpaces >> fill: space with: aCollection [
	| layout |
	RSEdgeBuilder line
		canvas: self canvas;
		shapes: aCollection;
		color: (Color blue alpha: 0.5);
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
	color := NSScale category20.
]

{ #category : #accessing }
RSForceLayoutInSpaces >> numberOfSpaces: anInteger [ 
	numberOfSpaces := anInteger
]

{ #category : #accessing }
RSForceLayoutInSpaces >> objects: aCollection [ 
	objects := aCollection
]

{ #category : #hooks }
RSForceLayoutInSpaces >> remove: shape [
	| layout |
	layout := shape propertyAt: #layout.
	shape connectedEdges do: [ :ed | layout removeEdge: ed ].
	layout removeNode: shape
	
]

{ #category : #hooks }
RSForceLayoutInSpaces >> renderIn: aCanvas [
	spaces := (1 to: numberOfSpaces) collect: [ :i | self createSpaceFor: i ].
	shapes := objects collect: [ :obj | self boxFor: obj ] as: RSGroup.
	self fill: spaces first with: shapes.
	aCanvas addAll: spaces.
	RSGridLayout on: spaces.
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
