"
I represent the basic canvas or paint area. I have a collection of shapes
"
Class {
	#name : #TSCanvas,
	#superclass : #TSObject,
	#instVars : [
		'shapes',
		'fixedShapes',
		'camera',
		'renderTree',
		'extent',
		'color',
		'announcer',
		'morph',
		'clearBackground',
		'animations',
		'showRectangles',
		'view'
	],
	#category : #'Roassal3-Trachel-Core'
}

{ #category : #visiting }
TSCanvas >> accept: visitor [
	visitor visitCanvas: self
]

{ #category : #animations }
TSCanvas >> addAnimation: anAnimation [
	animations add: anAnimation.
	anAnimation canvas: self.
	anAnimation start.
	self signalUpdate
]

{ #category : #'adding removing shapes' }
TSCanvas >> addBasicShape: aShape [
	shapes add: aShape
]

{ #category : #'adding removing shapes' }
TSCanvas >> addFixedShape: aShape [
	fixedShapes add: aShape
]

{ #category : #'adding removing shapes' }
TSCanvas >> addShape: aShape [
	aShape addedIn: self
]

{ #category : #animations }
TSCanvas >> animation [ 
	^ self animation: TSTransitionAnimation new.
]

{ #category : #animations }
TSCanvas >> animation: anAnimation [
	self addAnimation: anAnimation.
	^ anAnimation
]

{ #category : #animations }
TSCanvas >> animationFrom: array [
	| animation |
	animation := TSSequentialAnimation new.
	animation addAll: array.
	^ self animation: animation.
]

{ #category : #animations }
TSCanvas >> animations [
	^ animations
]

{ #category : #events }
TSCanvas >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #events }
TSCanvas >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TSCanvas >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
TSCanvas >> camera [
	^ camera
]

{ #category : #accessing }
TSCanvas >> camera: aCamera [
	camera := aCamera
]

{ #category : #accessing }
TSCanvas >> canvas [
	^ self
]

{ #category : #testing }
TSCanvas >> clearBackground [
	^ clearBackground
]

{ #category : #actions }
TSCanvas >> clearBackground: aBool [
	clearBackground := aBool
]

{ #category : #accessing }
TSCanvas >> color [ 
	^ color
]

{ #category : #accessing }
TSCanvas >> color: aColor [
	color := aColor
]

{ #category : #accessing }
TSCanvas >> encompassingRectangle [
	| r e |
	r := shapes
		ifEmpty: [ 0@0 corner: 0@0 ]
		ifNotEmpty: [ Rectangle merging: (shapes collect: #encompassingRectangle) ].
	e := r extent max: 1 @ 1.
	^ r topLeft extent: e
]

{ #category : #accessing }
TSCanvas >> extent [
	^ extent
]

{ #category : #accessing }
TSCanvas >> extent: aPoint [
	| evt |
	evt := TSExtentChangedEvent new
		shape: self;
		oldExtent: extent;
		newExtent: (extent := aPoint).
	self announce: evt
]

{ #category : #accessing }
TSCanvas >> fixedShapes [
	^ fixedShapes 
]

{ #category : #animations }
TSCanvas >> hasAnimation [
	"True if at least one animation is running"
	^ animations notEmpty
]

{ #category : #animations }
TSCanvas >> hasAnimation: anAnimation [
	"True if anAnimation is running"
	^ animations includes: anAnimation
]

{ #category : #actions }
TSCanvas >> hideEncompassingRectangles [
	showRectangles := false.
]

{ #category : #initialization }
TSCanvas >> initialize [
	super initialize.
	showRectangles := false.
	shapes := OrderedCollection new.
	fixedShapes := OrderedCollection new.
	animations := OrderedCollection new.
	clearBackground := true.
	color := Color white.
	extent := 500@500.
	camera := TSCamera new
		canvas: self;
		yourself.
]

{ #category : #'instance creation' }
TSCanvas >> morph [
	morph := TSAthensMorph new. 
	morph renderer: TSAthensRenderer new.
	morph canvas: self.
	^ morph
]

{ #category : #animations }
TSCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : #accessing }
TSCanvas >> numberOfFixedShapes [
	"Return the number of fixed shapes"
	^ fixedShapes size
]

{ #category : #accessing }
TSCanvas >> numberOfShapes [
	"Return the number of non-fixed shapes"
	^ shapes size
]

{ #category : #'instance creation' }
TSCanvas >> open [
	^ self openInWindowSized: 500@500
]

{ #category : #'instance creation' }
TSCanvas >> openInWindowSized: anExtentAsPoint [
	| morph window |
	morph := self morph.
	window := morph openInWindow.
	window extent: anExtentAsPoint.
	^ window
]

{ #category : #accessing }
TSCanvas >> parent [
	^ self
]

{ #category : #animations }
TSCanvas >> playAnimations [
	| shouldClean |
	shouldClean := false.
	animations do: [ :animation | 
		animation refresh. 
		animation hasCompleted 
			ifTrue: [ shouldClean := true. ] ].
	shouldClean ifTrue: [ 
		animations copy do: [ :animation |
			animation hasCompleted ifTrue: [ animation remove ] ] ].
]

{ #category : #actions }
TSCanvas >> pushBack: aShape [
	(shapes includes: aShape)
		ifTrue: [ shapes remove: aShape.
			shapes addFirst: aShape ].
	(fixedShapes includes: aShape)
		ifFalse: [ ^ self ].
	fixedShapes remove: aShape.
	fixedShapes addFirst: aShape
]

{ #category : #dependencies }
TSCanvas >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #'adding removing shapes' }
TSCanvas >> removeFixedShape: aShape [
	fixedShapes remove: aShape
]

{ #category : #'adding removing shapes' }
TSCanvas >> removeShape: shape [
	| evt |
	shapes remove: shape ifAbsent: [ self removeFixedShape: shape ].
	shape parent: nil.
	evt := TSShapeRemovedEvent new shape: shape.
	self announce: evt.
	shape announce: evt.
	
]

{ #category : #'adding removing shapes' }
TSCanvas >> setAsFixed: aShape [
	self
		removeShape: aShape;
		addFixedShape: aShape.
	aShape isFixed: true.
]

{ #category : #accessing }
TSCanvas >> shapeWithAction: eventClass forPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	| block |
	block := [ :list :pos| 
		list reverseDo: [ :s | | shape |
			shape := s shapeWithAction: eventClass forPosition: pos.
			shape ifNotNil: [ ^ shape ] ] ].
	block value: fixedShapes value: position.
	block value: shapes value: (self camera fromPixelToSpace: position).
	^ self
]

{ #category : #accessing }
TSCanvas >> shapeWithActionForPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	| block |
	block := [ :list :pos |
		list reverseDo: [ :s | | shape |
			shape := s shapeWithActionForPosition: pos.
			shape ifNotNil: [^ shape ] ] ].
	block value: fixedShapes value: position.
	block value: shapes value: (self camera fromPixelToSpace: position).
	^ self
	
]

{ #category : #accessing }
TSCanvas >> shapes [
	^shapes
]

{ #category : #actions }
TSCanvas >> showEncompassingRectangles [
	showRectangles := true.
]

{ #category : #testing }
TSCanvas >> showRectangles [
	^ showRectangles
]

{ #category : #updating }
TSCanvas >> signalUpdate [
	morph changed
]

{ #category : #animations }
TSCanvas >> tAnimation [ 
	^ TSTransitionAnimation new.
]

{ #category : #accessing }
TSCanvas >> topParent [
	^ self
]

{ #category : #accessing }
TSCanvas >> view [
	^ view
]

{ #category : #accessing }
TSCanvas >> view: aRSView [
	view := aRSView
]

{ #category : #events }
TSCanvas >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #actions }
TSCanvas >> zoomToFit [
	self camera zoomToFit: self extent * 0.9
]
