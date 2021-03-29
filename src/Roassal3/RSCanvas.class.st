"
<keyClass>
Roassal keeps its shapes (i.e., instance of a subclass of `RSShape`) into a canvas. The class `RSCanvas` implements the Roassal canvas.

*Responsibility*: keep the (i) structure of the Roassal shapes (both fixed and non-fixed) and (ii) the animations. `RSCanvas` hides the creation of the `RSAthensMorph`.

*Collaborators*: This class is the entry point of Roassal. As soon as one wishes to use Roassal, she has to go through a canvas.

*Variables*:
- `shapes` keeps a collection of shapes (i.e., instance of a subclass of `RSShape`) as an instance of `RSGroup`. Shapes contained in `shapes` are considered as non-fixed, which means that they are subject to the camera.
- `fixedShapes` is an instance of `RSGroup` that contains ""fixed"" shapes. A fixed shape is a shape that is not subject to the state of the camera. A fixed shape remains at the same position, independently if the canvas is scrolled.
- `color` is an instance of the Pharo class `Color` and is used to paint the background.
- `morph` refers to an instance of the class `RSAthensMorph`, which is the object that intersects Roassal and Morphic.
- `camera` refers to the camera of the canvas.
- `clearBackground` is a boolean indicating whether the background must be cleared at each refresh. This is useful sometime to obtain some interesting visual effects.

*Example*:
```Smalltalk
c := RSCanvas new.
c add: (RSLabel new text: 'Hello from Roassal').
c
```
"
Class {
	#name : #RSCanvas,
	#superclass : #RSObjectWithProperty,
	#traits : 'RSTContainer',
	#classTraits : 'RSTContainer classTrait',
	#instVars : [
		'shapes',
		'fixedShapes',
		'camera',
		'animations',
		'extent',
		'color',
		'clearBackground',
		'showRectangles',
		'nodes',
		'edges',
		'host'
	],
	#category : #'Roassal3-Core'
}

{ #category : #visiting }
RSCanvas >> accept: visitor [
	visitor visitCanvas: self
]

{ #category : #'adding nodes edges' }
RSCanvas >> add: aShape [
	"Main method to add a shape to a shape to a canvas"
	self
		assert: aShape notNil
		description: 'Nil cannot be added to a canvas'.
		
	self 
		assert: (aShape class inheritsFrom: RSShape)
		description: 'A shape must be provided'.
	aShape 
		addedIn: self;
		renderOn: self.
	^ aShape
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
	"This is a private method. Should not be called directly (use RSShape>>setAsFixed instead). 
Add a shape and make the shape fixed. It is therefore not subject to the camera.
```
c := RSCanvas new.

lbl := RSLabel text: 'Fixed Label'.
c addFixedShape: lbl.
lbl translateBy: 100 @ 20.

lbl := RSLabel text: 'Unfixed Label'.
c addShape: lbl.

c @ RSCanvasController.
```
"
	fixedShapes add: aShape
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

{ #category : #announcer }
RSCanvas >> announcementClasses [
	^ {RSCanvasEvent. RSShapeEvent} 
		flatCollect: [ :cls | 
			cls withAllSubclasses reject: [ :subcls|
				subcls hasSubclasses ] ]
]

{ #category : #accessing }
RSCanvas >> basicRectangle [
	"Return a rectangle encompassing all the elements"
	^ Rectangle origin: 0@0 extent: self extent
]

{ #category : #camera }
RSCanvas >> camera [
	"Return the camera used by the canvas:

For example:
```Smalltalk
c := RSCanvas new.
(1 to: 10) do: [ :i | c add: (RSEllipse new size: 20) ]. 
RSGridLayout on: c shapes.
c camera translateBy: -30 @ 50.
c 
```"
	^ camera
]

{ #category : #camera }
RSCanvas >> camera: aCamera [
	"Set a new camera for the canvas."
	camera := aCamera
]

{ #category : #accessing }
RSCanvas >> canvas [
	"Useful method to have it polymorphic with shapes"
	^ self
]

{ #category : #testing }
RSCanvas >> clearBackground [
	"Return whether the screen must be cleaned at each screen refresh"
	^ clearBackground
]

{ #category : #accessing }
RSCanvas >> clearBackground: aBool [
	"Determine if the canvas must be cleaned at each screen refresh. Per default it is, which means that if some shapes are translated, a footprint is left. This is useful to realize interesting visual effects.
	
For example, evaluate the following script:
```
c := RSCanvas new.
c clearBackground: false.
(1 to: 10) do: [ :i | c add: (RSEllipse new size: 20) ]. 
RSGridLayout on: c shapes.
c.
```

And execute the expression `c camera translateBy: 1 @ 1.`

"
	clearBackground := aBool
]

{ #category : #accessing }
RSCanvas >> color [ 
	"Return the color of the canvas background"
	^ color
]

{ #category : #accessing }
RSCanvas >> color: aColor [
	"Set the color of the canvas background.

```Smalltalk
c := RSCanvas new .
c color: Color blue.
c add: (RSBox new size: 30; color: #red).
c
```
"
	color := aColor.
	color isColor ifTrue: [ ^ self ].
	color := Color colorFrom: aColor.
]

{ #category : #private }
RSCanvas >> createMorph [
	"Create a Morph that contains myself. This is a private method"
	<deprecated: 'This only works when the host is a RSMorphicHost'>
	
	^ host	 createMorph
]

{ #category : #accessing }
RSCanvas >> deepNodes [
	"Return the list of all the nodes contained in the visualization"
	| result |
	result := OrderedCollection new. 
	self nodes do: [ :n |
		n addRecursivelyIn: result ].
	^ result
]

{ #category : #'looking up shapes' }
RSCanvas >> deepShapesFromModel: someObjects result: result [
	"Private method"
	self nodes do: [ :c | c deepShapesFromModel: someObjects result: result ]
]

{ #category : #'looking up shapes' }
RSCanvas >> deepShapesFromModels: someObjects result: result [
	"Private method"
	self nodes do: [ :c | c deepShapesFromModels: someObjects result: result ]
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
	"Set the extent of the canvas. This method is called when a window is resized. An event is raised when the extension happens. "
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

{ #category : #accessing }
RSCanvas >> fixedShapes: aCollection [ 
	fixedShapes := aCollection
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
	host := RSMorphicHost new canvas: self; yourself.
]

{ #category : #testing }
RSCanvas >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ false
]

{ #category : #accessing }
RSCanvas >> morph [
	"Return the Athens morph used by the canvas to render the visualization"
	<deprecated: 'This only works when the host is a RSMorphicHost'>
	
	^ host morph
]

{ #category : #accessing }
RSCanvas >> morph: aMorph [
	"Set the RSAthensMorph. The canvas will directly render in the morph"
	<deprecated: 'This only works when the host is a RSMorphicHost'>

	host morph: aMorph
]

{ #category : #animations }
RSCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : #'accessing - computed' }
RSCanvas >> numberOfDeepNodes [
	^ self deepNodes size
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

{ #category : #opening }
RSCanvas >> open [
	^ self openWithTitle: 'Roassal'
]

{ #category : #opening }
RSCanvas >> openOnce [
	^ self openOnceWithTitle: 'Roassal'
]

{ #category : #opening }
RSCanvas >> openOnceWithTitle: aTitle [
	"Open a visualization and record the position. When #openOnce is called a second time,
	the new window replace the previous one, at the recorded position. This method is useful when 
	demoing and scripting. Return the open window"
	| bounds win |
	bounds := nil. 
	Smalltalk at: #previousWindow ifPresent: [ :w | bounds := w bounds. w close ].
	win := self openWithTitle: aTitle.
	Smalltalk at: #previousWindow put: win.
	bounds ifNotNil: [
		win bounds: bounds ].
	^ win
]

{ #category : #opening }
RSCanvas >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	^ host openWithTitle: aTitleAsString
]

{ #category : #accessing }
RSCanvas >> parent [
	"A canvas has no parent. Shapes may have a parent other than the canvas when they are nested"
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

{ #category : #private }
RSCanvas >> privateShapes [
	^ shapes
]

{ #category : #private }
RSCanvas >> privateShapes: aCollection [
	shapes := aCollection
]

{ #category : #'shapes ordering' }
RSCanvas >> pushBack: aShape [
	"Shapes are ordered in the same order they are inserted. The order can be changed using #pushFront: and #pushBack.

For example:
```Smalltalk
c := RSCanvas new.
shape1 := RSEllipse new size: 50; color: #red.
shape2 := RSEllipse new size: 50; color: #blue.
shape2 translateBy: -25@0.
c add: shape1; add: shape2.
c pushBack: shape2.
c.
```	
"
	| col |
	col := aShape isFixed 
		ifTrue: [ fixedShapes ]
		ifFalse: [ shapes ].
	col 
		remove: aShape;
		addFirst: aShape.
]

{ #category : #'shapes ordering' }
RSCanvas >> pushFront: aShape [
	"Shapes are ordered in the same order they are inserted. The order can be changed using #pushFront: and #pushBack.

For example:
```Smalltalk
c := RSCanvas new.
shape1 := RSEllipse new size: 50; color: #red.
shape2 := RSEllipse new size: 50; color: #blue.
shape2 translateBy: -25@0.
c add: shape1; add: shape2.
c pushFront: shape1.
c.
```
The red circle is in front of the blue one, despite the red one is inserted first.
"
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
	"Return all the shapes added to the canvas. An empty canvas would return an empty collection.
	
For example
```Smalltalk
s1 := RSBox new.
s2 := RSEllipse new.
c := RSCanvas new.
c add: s1; add: s2.
```
The expression `c shapes` returns a `RSGroup` containing both `s1` and `s2`
"
	^ shapes copy
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

	host signalUpdate
]

{ #category : #accessing }
RSCanvas >> topParent [
	"A top parent is a canvas"
	^ self
]

{ #category : #'accessing - computed' }
RSCanvas >> transform: aPoint [
	^ aPoint
]

{ #category : #accessing }
RSCanvas >> useMorphicHost [

	host := RSMorphicHost new
		        canvas: self;
		        yourself
]

{ #category : #'accessing - computed' }
RSCanvas >> visibleRectangle [
	^ Rectangle 
		floatCenter: self camera position
		extent: self extent / self camera scale.
]

{ #category : #camera }
RSCanvas >> zoomToFit [
	"Adjust the camera to make all the displayed shapes visible.

```Smalltalk
	c := RSCanvas new.

	blueBox := RSBox new
		          size: 80;
		          color: #blue.
	redBox := RSBox new
		          size: 80;
		          color: #red.

	c
		add: blueBox;
		add: redBox.
	blueBox translateBy: 40 @ 20.
	c zoomToFit
```
"
	self camera zoomToFit
]
