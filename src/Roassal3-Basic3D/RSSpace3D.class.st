"
I am the basic space, you can add mesh 3d instances in this object
"
Class {
	#name : #RSSpace3D,
	#superclass : #Object,
	#instVars : [
		'extent',
		'tmat',
		'meshes',
		'elements',
		'canvas'
	],
	#category : #'Roassal3-Basic3D-Core'
}

{ #category : #adding }
RSSpace3D >> add: mesh [
	meshes add: mesh
]

{ #category : #building }
RSSpace3D >> build [

	self
		buildElements;
		buildEvents
]

{ #category : #building }
RSSpace3D >> buildElements [
	elements := Dictionary new.
	meshes do: [ :mesh | | meshElements |
		self updateMatrix: mesh.
		meshElements := mesh elements.
		canvas addAll: meshElements.
		elements at: mesh put: meshElements.
		mesh update.
		 ]
]

{ #category : #building }
RSSpace3D >> buildEvents [

	| prev |
	prev := nil.
	canvas
		when: RSMouseDragStart
		do: [ :evt | prev := evt positionFromCamera ]
		for: self;
		when: RSMouseDragging do: [ :evt | 
			| p theta |
			tmat identity.
			p := evt positionFromCamera.
			theta := prev - p * 360 / extent.
			tmat
				xrot: theta y degreesToRadians;
				yrot: theta x degreesToRadians.
			meshes do: [ :m | m matrix mult: tmat ].
			self draw.
			canvas signalUpdate.
			prev := p ]
		for: self
]

{ #category : #accessing }
RSSpace3D >> canvas [
	^ canvas
]

{ #category : #accessing }
RSSpace3D >> canvas: aRSCanvas [
	canvas := aRSCanvas
]

{ #category : #private }
RSSpace3D >> draw [
	meshes do: [ :mesh |
		self updateMatrix: mesh.
		mesh update ].
	canvas signalUpdate
]

{ #category : #accessing }
RSSpace3D >> elements [
	^ elements
]

{ #category : #accessing }
RSSpace3D >> extent [
	^ extent
]

{ #category : #accessing }
RSSpace3D >> extent: aPoint [
	extent := aPoint
]

{ #category : #ui }
RSSpace3D >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['View'];
		initializeCanvas: [
			canvas color: Smalltalk ui theme backgroundColor.
			canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].

			canvas ]
]

{ #category : #initialization }
RSSpace3D >> initialize [
	super initialize.
	self
		extent: 400 asPoint;
		canvas: RSCanvas new.
	meshes := OrderedCollection new.
	tmat := RSMatrix3D new
]

{ #category : #ui }
RSSpace3D >> inspector [
	<inspectorPresentationOrder: 90 title: 'View'>
	canvas color: Smalltalk ui theme backgroundColor.
	canvas zoomToFit.

	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]

{ #category : #accessing }
RSSpace3D >> meshes [
	^ meshes
]

{ #category : #private }
RSSpace3D >> updateMatrix: mesh [
	mesh
		transformed: false;
		transform
]
