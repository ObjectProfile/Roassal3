"
I am the basic space, you can add mesh 3d instances in this object
"
Class {
	#name : #RSSpace3D,
	#superclass : #Object,
	#instVars : [
		'extent',
		'tmat',
		'view',
		'meshes',
		'elements'
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
		buildEvents.
	
]

{ #category : #building }
RSSpace3D >> buildElements [
	elements := Dictionary new.
	meshes do: [ :mesh | | meshElements |
		self updateMatrix: mesh.
		meshElements := mesh elements.
		view addAll: meshElements.
		elements at: mesh put: meshElements.
		mesh update.
		 ].
]

{ #category : #building }
RSSpace3D >> buildEvents [
	| prev |
	prev := nil.
	view 
		when: TSMouseDragStart do: [ :evt | 
			prev := evt positionFromCamera ];
		when: TSMouseDragging do: [ :evt | | p theta |
			tmat identity.
			p := evt positionFromCamera.
			theta := (prev - p )* 360 / extent.
			tmat 
				xrot: theta y degreesToRadians;
				yrot: theta x degreesToRadians.
			meshes do: [ :m | m matrix mult: tmat].
			self draw.
			view signalUpdate.
			prev := p.
			 ].
]

{ #category : #private }
RSSpace3D >> draw [
	meshes do: [ :mesh |
		self updateMatrix: mesh.
		mesh update ].
	view signalUpdate.
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
		initializeView: [ 
			view color: Smalltalk ui theme backgroundColor.
			view when: TSExtentChangedEvent do: [ view zoomToFit ]. 
			
			view ].
]

{ #category : #initialization }
RSSpace3D >> initialize [
	super initialize.
	self
		extent: 400 asPoint;
		view: RSView new.
	meshes := OrderedCollection new.
	tmat := RSMatrix3D new
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

{ #category : #accessing }
RSSpace3D >> view [
	^ view
]

{ #category : #accessing }
RSSpace3D >> view: aView [
	view := aView
]
