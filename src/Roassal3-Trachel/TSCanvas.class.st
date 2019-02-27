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
		'animations'
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

{ #category : #adding }
TSCanvas >> addFixedShape: aShape [
	fixedShapes add: aShape.
	aShape canvas: self
]

{ #category : #adding }
TSCanvas >> addShape: aShape [
	aShape isFixed
		ifTrue: [ ^ self addFixedShape: aShape ].
	shapes add: aShape.
	aShape canvas: self
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
	announcer announce: anEvent
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

{ #category : #accessing }
TSCanvas >> clearBackground [
	^ clearBackground
]

{ #category : #accessing }
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
TSCanvas >> extent [
	^ extent
]

{ #category : #accessing }
TSCanvas >> extent: aPoint [
	| evt |
	evt := TSResizeCanvasEvent new
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

{ #category : #initialization }
TSCanvas >> initialize [
	super initialize.
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

{ #category : #dependencies }
TSCanvas >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #'adding removing shapes' }
TSCanvas >> removeFixedShape: aShape [
	fixedShapes := fixedShapes remove: aShape
]

{ #category : #'adding removing shapes' }
TSCanvas >> removeShape: shape [
	shapes remove: shape ifAbsent: [ self removeFixedShape: shape ].
	shape canvas: nil.
	
]

{ #category : #accessing }
TSCanvas >> shapeForPosition: position [
	"Return the Trachel shape located at position"
	fixedShapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].

	shapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TSCanvas >> shapeForPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	fixedShapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].

	shapes reverseDo: [ :s | 
		(s includesPoint: (self camera fromPixelToSpace: position)) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TSCanvas >> shapeWithAction: eventClass forPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	| pos |
	fixedShapes reverseDo: [ :s | 
		((s includesPoint: position) and: [ s announcer handleEventClass: eventClass ]) ifTrue: [ ^ s ] ].
	pos := self camera fromPixelToSpace: position.
	shapes reverseDo: [ :s | 
		((s includesPoint: pos) 
			and: [ s announcer handleEventClass: eventClass ]) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TSCanvas >> shapeWithActionForPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	| pos |
	fixedShapes reverseDo: [ :s | 
		((s includesPoint: position) and: [ s hasEventCallback ]) ifTrue: [ ^ s ] ].
	pos := self camera fromPixelToSpace: position.
	shapes reverseDo: [ :s | 
		((s includesPoint: pos) 
			and: [ s hasEventCallback ]) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TSCanvas >> shapes [
	^shapes
]

{ #category : #updating }
TSCanvas >> signalUpdate [
	morph changed
]

{ #category : #animations }
TSCanvas >> tAnimation [ 
	^ TSTransitionAnimation new.
]

{ #category : #events }
TSCanvas >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
