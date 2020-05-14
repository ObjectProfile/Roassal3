"
<keyClass>
Roassal keeps its shapes (i.e., instance of a subclass of `RSShape`) into a canvas. The class `RSCanvas` implements the Roassal canvas.

*Responsibility*: keep the (i) structure of the Roassal shapes (both fixed and non-fixed) and (ii) the animations. `RSCanvas` hides the creation of the `RSAthensMorph`.

*Collaborators*: This class is the entry point of Roassal. As soon as one wishes to use Roassal, she has to go through a canvas.

*Variables*:
`shapes` keeps a collection of shapes (i.e., instance of a subclass of `RSShape`) as an instance of `RSGroup`. Shapes contained in `shapes` are considered as non-fixed, which means that they are subject to the camera.

`fixedShapes` is an instance of `RSGroup` that contains ""fixed"" shapes. A fixed shape is a shape that is not subject to the state of the camera. A fixed shape remains at the same position, independently if the canvas is scrolled.

`color` is an instance of the Pharo class `Color` and is used to paint the background.

`morph` refers to an instance of the class `RSAthensMorph`, which is the object that intersects Roassal and Morphic.

`camera` refers to the camera of the canvas.

`clearBackground` is a boolean indicating whether the background must be cleared at each refresh. This is useful sometime to obtain some interesting visual effects.

*Example*:
```Smalltalk
c := RSCanvas new.
c add: (RSLabel new text: 'Hello from Roassal').
c
```
"
Class {
	#name : #RSCanvas,
	#superclass : #RSPropertableObject,
	#traits : 'RSTContainer',
	#classTraits : 'RSTContainer classTrait',
	#instVars : [
		'shapes',
		'fixedShapes',
		'camera',
		'animations',
		'extent',
		'color',
		'morph',
		'clearBackground',
		'showRectangles',
		'nodes',
		'edges'
	],
	#category : #'Roassal3-Core'
}

{ #category : #visiting }
RSCanvas >> accept: visitor [
	visitor visitCanvas: self
]

{ #category : #animations }
RSCanvas >> addAnimation: anAnimation [
	"Schedule an animation, and run it until its completion"
	animations add: anAnimation.
	anAnimation canvas: self.
	anAnimation start.
	self signalUpdate
]

{ #category : #'adding removing shapes' }
RSCanvas >> addBasicShape: aShape [
	shapes add: aShape
]

{ #category : #'adding removing shapes' }
RSCanvas >> addFixedShape: aShape [
	fixedShapes add: aShape.
]

{ #category : #'adding removing shapes' }
RSCanvas >> addShape: aShape [
	aShape addedIn: self
]

{ #category : #'adding removing shapes' }
RSCanvas >> addShape: aShape before: otherShape [
	aShape addedIn: self.
	shapes remove: aShape.
	shapes add: aShape before: otherShape.
]

{ #category : #animations }
RSCanvas >> animations [
	^ animations
]

{ #category : #announcer }
RSCanvas >> announce: anEventOrAnEventClass [
	"Send an event"
	| theEventToSend |
	announcer ifNil: [ ^ self ].
	theEventToSend := anEventOrAnEventClass value asAnnouncement.
	theEventToSend canvas: self.
	announcer announce: theEventToSend.
]

{ #category : #accessing }
RSCanvas >> basicRectangle [
	^ Rectangle origin: 0@0 extent: self extent
]

{ #category : #camera }
RSCanvas >> camera [
	^ camera
]

{ #category : #camera }
RSCanvas >> camera: aCamera [
	camera := aCamera
]

{ #category : #accessing }
RSCanvas >> canvas [
	^ self
]

{ #category : #testing }
RSCanvas >> clearBackground [
	^ clearBackground
]

{ #category : #accessing }
RSCanvas >> clearBackground: aBool [
	clearBackground := aBool
]

{ #category : #accessing }
RSCanvas >> color [ 
	^ color
]

{ #category : #accessing }
RSCanvas >> color: aColor [
	color := aColor.
	color isColor ifTrue: [ ^ self ].
	color := Color colorFrom: aColor.
]

{ #category : #'morph creation' }
RSCanvas >> createMorph [
	"Create a Morph that contains myself."
	morph := RSAthensMorph new. 
	morph renderer: RSAthensRenderer new.
	morph canvas: self.
	^ morph
]

{ #category : #accessing }
RSCanvas >> edges [
	^ self privateEdges
		ifNil: [ | res |
			self privateEdges: (res := RSGroup new).
			res ]
]

{ #category : #'accessing - computed' }
RSCanvas >> encompassingRectangle [
	^ self encompassingRectangleOf: shapes
]

{ #category : #'accessing - computed' }
RSCanvas >> encompassingRectangleOf: aCollectionOfShapes [
	| r |
	r := aCollectionOfShapes
		ifEmpty: [ 0@0 corner: 0@0 ]
		ifNotEmpty: [ Rectangle 
			merging: (aCollectionOfShapes 
				collect: [:each | each encompassingRectangle] ) ].
	^ r topLeft extent: (self camera class maxExtentFor: r)
]

{ #category : #accessing }
RSCanvas >> extent [
	^ extent
]

{ #category : #accessing }
RSCanvas >> extent: aPoint [
	| evt |
	evt := RSExtentChangedEvent new
		shape: self;
		oldExtent: extent;
		newExtent: (extent := aPoint).
	self announce: evt
]

{ #category : #accessing }
RSCanvas >> fixedShapes [
	"Return the list of shapes that are fixed, i.e., not subjet to the camera"
	^ fixedShapes 
]

{ #category : #matrix }
RSCanvas >> globalMatrix [
	^ AthensAffineTransform new
]

{ #category : #animations }
RSCanvas >> hasAnimation [
	"True if at least one animation is running"
	^ animations notEmpty
]

{ #category : #animations }
RSCanvas >> hasAnimation: anAnimation [
	"True if anAnimation is running"
	^ animations includes: anAnimation
]

{ #category : #'debug support' }
RSCanvas >> hideEncompassingRectangles [
	showRectangles := false.
]

{ #category : #initialization }
RSCanvas >> initialize [
	super initialize.
	showRectangles := false.
	shapes := RSGroup new.
	fixedShapes := RSGroup new.
	nodes := RSGroup new.
	edges := RSGroup new.
	animations := OrderedCollection new.
	clearBackground := true.
	color := Color white.
	extent := 500@500.
	camera := RSCamera new
		canvas: self;
		yourself.
]

{ #category : #testing }
RSCanvas >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ false
]

{ #category : #accessing }
RSCanvas >> morph [
	^ morph
]

{ #category : #accessing }
RSCanvas >> morph: aMorph [
	morph := aMorph
]

{ #category : #accessing }
RSCanvas >> nodes [ 
	^ self privateNodes
		ifNil: [ | res |
			self privateNodes: (res := RSGroup new).
			res ]
]

{ #category : #animations }
RSCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : #accessing }
RSCanvas >> numberOfFixedShapes [
	"Return the number of fixed shapes"
	^ fixedShapes size
]

{ #category : #accessing }
RSCanvas >> numberOfShapes [
	"Return the number of non-fixed shapes"
	^ shapes size
]

{ #category : #'morph creation' }
RSCanvas >> open [
	| window |
	self createMorph.
	window := morph openInWindow.
	window extent: 500@500.
	morph privateOwner: window.
	^ window
	
]

{ #category : #'morph creation' }
RSCanvas >> openOnce [
	"Open a visualization and record the position. When #openOnce is called a second time,
	the new window replace the previous one, at the recorded position. This method is useful when 
	demoing and scripting."
	| bounds win |
	bounds := nil. 
	Smalltalk at: #previousWindow ifPresent: [ :w | bounds := w bounds. w close ].
	win := self open.
	Smalltalk at: #previousWindow put: win.
	bounds ifNotNil: [
		win bounds: bounds ]
]

{ #category : #accessing }
RSCanvas >> parent [
	^ self
]

{ #category : #animations }
RSCanvas >> playAnimations [
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

{ #category : #private }
RSCanvas >> privateEdges [
	^ edges
]

{ #category : #private }
RSCanvas >> privateEdges: aTSGroup [
	edges := aTSGroup
]

{ #category : #private }
RSCanvas >> privateNodes [
	^ nodes
]

{ #category : #private }
RSCanvas >> privateNodes: aTSGroup [
	nodes := aTSGroup
]

{ #category : #'shapes controling' }
RSCanvas >> pushBack: aShape [
	| col |
	col := aShape isFixed 
		ifTrue: [ fixedShapes ]
		ifFalse: [ shapes ].
	col 
		remove: aShape;
		addFirst: aShape.
]

{ #category : #'shapes controling' }
RSCanvas >> pushFront: aShape [
	| col |
	col := aShape isFixed 
		ifTrue: [ fixedShapes ]
		ifFalse: [ shapes ].
	col 
		remove: aShape ifAbsent: [];
		addLast: aShape.
]

{ #category : #'adding removing shapes' }
RSCanvas >> removeFixedShape: aShape [
	fixedShapes remove: aShape
]

{ #category : #'adding removing shapes' }
RSCanvas >> removeShape: shape [
	| evt index |
	index := shapes indexOf: shape.
	index = 0 
		ifTrue: [ index := fixedShapes indexOf: shape.
			index = 0 ifFalse: [ fixedShapes remove: shape ] ]
		ifFalse: [ shapes removeAt: index ].
	
	shape parent: nil.
	evt := RSShapeRemovedEvent new shape: shape.
	self announce: evt.
	shape announce: evt.
	
]

{ #category : #'adding removing shapes' }
RSCanvas >> setAsFixed: aShape [
	self removeShape: aShape.
	aShape isFixed: true.
	self addShape: aShape.
	
]

{ #category : #'accessing - shapes' }
RSCanvas >> shapeWithAction: eventClass forPositionInPixels: position [
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

{ #category : #'accessing - shapes' }
RSCanvas >> shapeWithActionForPositionInPixels: position [
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
RSCanvas >> shapes [
	^ shapes
]

{ #category : #accessing }
RSCanvas >> shapes: aCollection [
	shapes := aCollection
]

{ #category : #'accessing - shapes' }
RSCanvas >> shapesFromModels: objects [
	"Return shapes that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	^ self nodes shapesFromModels: objects

]

{ #category : #'debug support' }
RSCanvas >> showEncompassingRectangles [
	showRectangles := true.
]

{ #category : #testing }
RSCanvas >> showRectangles [
	^ showRectangles
]

{ #category : #updating }
RSCanvas >> signalUpdate [
	"Signal a platform signal that the canvas should be refreshed. This is important when some shapes are modified (color or position)."
	morph changed
]

{ #category : #accessing }
RSCanvas >> topParent [
	^ self
]

{ #category : #'accessing - computed' }
RSCanvas >> transform: aPoint [
	^ aPoint
]

{ #category : #camera }
RSCanvas >> zoomToFit [
	self camera zoomToFit
]
