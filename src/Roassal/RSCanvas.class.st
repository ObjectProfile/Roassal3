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
	#name : 'RSCanvas',
	#superclass : 'RSObjectWithProperty',
	#traits : 'RSTContainer',
	#classTraits : 'RSTContainer classTrait',
	#instVars : [
		'shapes',
		'fixedShapes',
		'nodes',
		'edges',
		'camera',
		'animations',
		'extent',
		'color',
		'host',
		'shouldClearBackground',
		'shouldShowDirtyRectangle',
		'shouldShowEncompassingRectangles'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'examples' }
RSCanvas class >> exampleSimple [
	| canvas |
	canvas := self new.
	canvas color: Color black.
	"add some shapes here"
	^ canvas open
]

{ #category : 'examples' }
RSCanvas class >> exampleSpec [
	| canvas spec |
	canvas := self new.
	canvas color: Color black.
	spec := SpMorphPresenter new.
	spec morph: canvas createMorph.
	^ spec open window
]

{ #category : 'instance creation' }
RSCanvas class >> newCenterMiddleOrigin [
	^ self new
		originCenterMiddle;
		yourself
]

{ #category : 'instance creation' }
RSCanvas class >> newTopLeftOrigin [
	^ self new
		originTopLeft;
		yourself
]

{ #category : 'visiting' }
RSCanvas >> accept: visitor [
	visitor visitCanvas: self
]

{ #category : 'adding - nodes edges' }
RSCanvas >> add: aShape [
	"Main method to add a shape to a shape to a canvas"
	self
		assert: aShape isNotNil
		description: 'Nil cannot be added to a canvas'.

	self
		assert: (aShape class inheritsFrom: RSShape)
		description: 'A shape must be provided'.
	aShape
		addedIn: self;
		renderOn: self.
	^ aShape
]

{ #category : 'animations' }
RSCanvas >> addAnimation: anAnimation [
	"Schedule an animation, and run it until its completion"
	animations add: anAnimation.
	anAnimation canvas: self.
	anAnimation start.
	self signalUpdate
]

{ #category : 'adding - removing shapes' }
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
	fixedShapes add: aShape.
	aShape entryIndex: fixedShapes size.
	aShape invalidate
]

{ #category : 'animations' }
RSCanvas >> animations [
	^ animations
]

{ #category : 'announcer' }
RSCanvas >> announce: anEventOrAnEventClass [
	"Send an event"
	| theEventToSend |
	announcer ifNil: [ ^ self ].
	theEventToSend := anEventOrAnEventClass value asAnnouncement.
	theEventToSend canvas: self.
	announcer announce: theEventToSend
]

{ #category : 'announcer' }
RSCanvas >> announcementClasses [
	^ {RSCanvasEvent. RSShapeEvent}
		flatCollect: [ :cls |
			cls withAllSubclasses reject: [ :subcls|
				subcls hasSubclasses ] ]
]

{ #category : 'converting' }
RSCanvas >> asForm [
	| canvas |
	canvas := FormCanvas extent: self extent.
	(self morph ifNil: [ self createMorph ])
		extent: self extent;
		drawOn: canvas.
	^ canvas form
]

{ #category : 'accessing' }
RSCanvas >> background [
	^ self color
]

{ #category : 'accessing' }
RSCanvas >> background: aColor [
	self color: aColor
]

{ #category : 'accessing' }
RSCanvas >> basicRectangle [
	"Return a rectangle encompassing all the elements"
	^ Rectangle origin: 0@0 extent: self extent
]

{ #category : 'camera' }
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

{ #category : 'camera' }
RSCanvas >> camera: anRSCamera [
	"Set a new camera for the canvas."
	camera := anRSCamera
]

{ #category : 'accessing' }
RSCanvas >> canvas [
	"Useful method to have it polymorphic with shapes"
	^ self
]

{ #category : 'removing' }
RSCanvas >> clear [
	self shapes copy do: #remove.
	self announcer: nil.
	self signalUpdate
]

{ #category : 'accessing' }
RSCanvas >> color [
	"Return the color of the canvas background"
	^ color
]

{ #category : 'accessing' }
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
	color := Color colorFrom: aColor
]

{ #category : 'private' }
RSCanvas >> createMorph [
	"Create a Morph that contains myself. This is a private method"
	<deprecated: 'This only works when the host is a RSMorphicHost'>

	^ host	 createMorph
]

{ #category : 'accessing' }
RSCanvas >> deepNodes [
	"Return the list of all the nodes contained in the visualization"
	| result |
	result := OrderedCollection new.
	self nodes do: [ :n |
		n addRecursivelyIn: result ].
	^ result
]

{ #category : 'looking up shapes' }
RSCanvas >> deepShapesFromModel: someObjects result: result [
	"Private method"
	self nodes do: [ :c | c deepShapesFromModel: someObjects result: result ]
]

{ #category : 'looking up shapes' }
RSCanvas >> deepShapesFromModels: someObjects result: result [
	"Private method"
	self nodes do: [ :c | c deepShapesFromModels: someObjects result: result ]
]

{ #category : 'initialization' }
RSCanvas >> defaultExtent [
	^ 500@500
]

{ #category : 'dirty areas' }
RSCanvas >> dirtyRectangle [
	^ host dirtyRectangle
]

{ #category : 'dirty areas' }
RSCanvas >> dirtyRectangle: rectangle [
	host dirtyRectangle: rectangle
]

{ #category : 'accessing - computed' }
RSCanvas >> encompassingRectangle [
	^ self encompassingRectangleOf: shapes
]

{ #category : 'accessing - computed' }
RSCanvas >> encompassingRectangleOf: aCollectionOfShapes [
	| r |
	r := aCollectionOfShapes
		ifEmpty: [ 0@0 corner: 0@0 ]
		ifNotEmpty: [ Rectangle
			merging: (aCollectionOfShapes
				collect: [:each | each encompassingRectangle] ) ].
	^ r topLeft extent: (self camera class maxExtentFor: r)
]

{ #category : 'accessing' }
RSCanvas >> extent [
	^ extent
]

{ #category : 'accessing' }
RSCanvas >> extent: aPoint [
	"Set the extent of the canvas. This method is called when a window is resized. An event is raised when the extension happens. "
	extent = aPoint ifTrue: [ ^ self ].
	self notifyExtentChanged: aPoint.
	self camera invalidate
]

{ #category : 'accessing' }
RSCanvas >> fixedShapes [
	"Return the list of shapes that are fixed, i.e., not subjet to the camera"
	^ fixedShapes
]

{ #category : 'accessing' }
RSCanvas >> fixedShapes: aCollection [
	fixedShapes := aCollection
]

{ #category : 'matrix' }
RSCanvas >> globalMatrix [
	^ AthensAffineTransform new
]

{ #category : 'animations' }
RSCanvas >> hasAnimation [
	"True if at least one animation is running"
	^ animations notEmpty
]

{ #category : 'animations' }
RSCanvas >> hasAnimation: anAnimation [
	"True if anAnimation is running"
	^ animations includes: anAnimation
]

{ #category : 'debug support' }
RSCanvas >> hideDirtyRectangle [
	self shouldShowDirtyRectangle: false
]

{ #category : 'debug support' }
RSCanvas >> hideEncompassingRectangles [
	self shouldShowEncompassingRectangles: false
]

{ #category : 'accessing' }
RSCanvas >> host [
	^ host
]

{ #category : 'private' }
RSCanvas >> indexesFromRootIn: aCollection [
	"do nothing"
]

{ #category : 'initialization' }
RSCanvas >> initialize [
	super initialize.
	shapes := RSGroup new.
	fixedShapes := RSGroup new.
	self shapeCollection: self defaultShapeCollection.
	self
		shouldClearBackground: true;
		shouldShowDirtyRectangle: false;
		shouldShowEncompassingRectangles: false.
	nodes := RSGroup new.
	edges := RSGroup new.
	animations := OrderedCollection new.
	color := Color white.
	extent := self defaultExtent.
	camera := RSCamera new
		canvas: self;
		yourself.
	self useMorphicHost
]

{ #category : 'updating' }
RSCanvas >> invalidate [
	"this will call to draw all the visible area"
	self camera invalidate.
	self signalUpdate
]

{ #category : 'accessing' }
RSCanvas >> lastMousePosition [
	^ host lastMousePosition
]

{ #category : 'accessing' }
RSCanvas >> morph [
	"Return the Athens morph used by the canvas to render the visualization"
	<deprecated: 'This only works when the host is a RSMorphicHost'>

	^ host morph
]

{ #category : 'accessing' }
RSCanvas >> morph: aMorph [
	"Set the RSAthensMorph. The canvas will directly render in the morph"
	<deprecated: 'This only works when the host is a RSMorphicHost'>

	host morph: aMorph
]

{ #category : 'actions' }
RSCanvas >> notifyExtentChanged: aNewExtent [
	| evt |
	evt := RSExtentChangedEvent new
		shape: self;
		oldExtent: extent;
		newExtent: (extent := aNewExtent).
	self announce: evt
]

{ #category : 'animations' }
RSCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : 'accessing - computed' }
RSCanvas >> numberOfDeepNodes [
	^ self deepNodes size
]

{ #category : 'accessing' }
RSCanvas >> numberOfFixedShapes [
	"Return the number of fixed shapes"
	^ fixedShapes size
]

{ #category : 'accessing' }
RSCanvas >> numberOfShapes [
	"Return the number of non-fixed shapes"
	^ shapes size
]

{ #category : 'opening' }
RSCanvas >> open [
	^ self openWithTitle: host defaultWindowTitle
]

{ #category : 'opening' }
RSCanvas >> openOnce [
	^ self openOnceWithTitle: 'Roassal'
]

{ #category : 'opening' }
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

{ #category : 'opening' }
RSCanvas >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	^ host openWithTitle: aTitleAsString
]

{ #category : 'camera' }
RSCanvas >> originCenterMiddle [
	camera originMode: RSCamera originCenterMiddle
]

{ #category : 'camera' }
RSCanvas >> originMode [
	^ camera originMode
]

{ #category : 'camera' }
RSCanvas >> originTopLeft [
	camera originMode: RSCamera originTopLeft
]

{ #category : 'accessing' }
RSCanvas >> parent [
	"A canvas has no parent. Shapes may have a parent other than the canvas when they are nested"
	^ self
]

{ #category : 'animations' }
RSCanvas >> playAnimations [
	| shouldClean |
	shouldClean := false.
	animations do: [ :animation |
		animation refresh.
		animation hasCompleted
			ifTrue: [ shouldClean := true. ] ].
	shouldClean ifTrue: [
		animations copy do: [ :animation |
			animation hasCompleted ifTrue: [ animation remove ] ] ]
]

{ #category : 'accessing' }
RSCanvas >> position [
	^ self camera position
]

{ #category : 'private' }
RSCanvas >> privateEdges [
	^ edges
]

{ #category : 'private' }
RSCanvas >> privateEdges: aTSGroup [
	edges := aTSGroup
]

{ #category : 'private' }
RSCanvas >> privateExtent: aRect [

	extent := aRect
]

{ #category : 'private' }
RSCanvas >> privateNodes [
	^ nodes
]

{ #category : 'private' }
RSCanvas >> privateNodes: aTSGroup [
	nodes := aTSGroup
]

{ #category : 'private' }
RSCanvas >> privateShapes [
	^ shapes
]

{ #category : 'private' }
RSCanvas >> privateShapes: aCollection [
	shapes := aCollection
]

{ #category : 'adding - removing shapes' }
RSCanvas >> removeFixedShape: aShape [
	fixedShapes remove: aShape
]

{ #category : 'adding - removing shapes' }
RSCanvas >> removeShape: shape [
	| evt collection |
	shape invalidate.
	collection := shape isFixed
		ifTrue: [ fixedShapes ]
		ifFalse: [ shapes ].
	shape isFixed
		ifFalse: [ self shapeCollection remove: shape ].
	collection remove: shape.
	shape entryIndex to: collection size
		do: [ :i | (collection at: i) entryIndex: i ].
	shape parent: nil.
	evt := RSShapeRemovedEvent new
		       shape: shape;
		       canvas: self;
		       yourself.
	self announce: evt.
	shape announce: evt
]

{ #category : 'dirty areas' }
RSCanvas >> resetDirtyRectangle [
	host dirtyRectangle: nil
]

{ #category : 'adding - removing shapes' }
RSCanvas >> setAsFixed: aShape [
	self removeShape: aShape.
	aShape isFixed: true.
	self addShape: aShape
]

{ #category : 'accessing' }
RSCanvas >> shapeCollection: anRSShapeCollection [
	shapeCollection := anRSShapeCollection.
	shapeCollection bulkLoad: shapes
]

{ #category : 'event processing' }
RSCanvas >> shapeWithAction: eventClass forPositionInPixels: position [
	|  result |
	fixedShapes reverseDo: [ :s | | shapeWithAction |
		shapeWithAction := s shapeWithAction: eventClass forPosition: position.
		shapeWithAction ifNotNil: [ ^ shapeWithAction ] ].

	result := self shapeWithActionForPosition: (self camera fromPixelToSpace: position).
	result ifNil: [ ^ self ].
	(result announcer handleEventClass: eventClass)
		ifTrue: [ ^ result ].
	^ self
]

{ #category : 'event processing' }
RSCanvas >> shapeWithActionForPosition: aPositionInSpace [

	| result |
	result := self shapesWithActionForPosition: aPositionInSpace.
	result ifEmpty: [ ^ nil ].
	^ result first
]

{ #category : 'event processing' }
RSCanvas >> shapeWithActionForPositionInPixels: position [
	| aShape |
	fixedShapes reverseDo: [ :s | | shapeWithAction |
		shapeWithAction := s shapeWithActionForPosition: position.
		shapeWithAction ifNotNil: [^ shapeWithAction ]
	].
	aShape := self shapeWithActionForPosition: (self camera fromPixelToSpace: position).
	aShape ifNil: [ aShape := self ].
	^ aShape
]

{ #category : 'accessing' }
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

{ #category : 'looking up shapes' }
RSCanvas >> shapesFromModels: objects [
	"Return shapes that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	^ self nodes shapesFromModels: objects
]

{ #category : 'accessing - computed' }
RSCanvas >> shapesToRender [
	^ shapes select: [ :s | s isDirty ]
]

{ #category : 'event processing' }
RSCanvas >> shapesWithActionForPosition: aPositionInSpace [
	| result |
	result := self shapeCollection entriesAtPoint: aPositionInSpace.
	result := result select: [ :s | s hasEventCallback ].
	^ result
]

{ #category : 'accessing' }
RSCanvas >> shouldClearBackground [
	"Return whether the screen must be cleaned at each screen refresh"
	^ shouldClearBackground
]

{ #category : 'accessing' }
RSCanvas >> shouldClearBackground: aBoolean [
	"Determine if the canvas must be cleaned at each screen refresh. Per default it is, which means that if some shapes are translated, a footprint is left. This is useful to realize interesting visual effects.

For example, evaluate the following script:
```
c := RSCanvas new.
c shouldClearBackground: false.
(1 to: 10) do: [ :i | c add: (RSEllipse new size: 20) ].
RSGridLayout on: c shapes.
c.
```

And execute the expression `c camera translateBy: 1 @ 1.`

"
	shouldClearBackground := aBoolean
]

{ #category : 'accessing' }
RSCanvas >> shouldShowDirtyRectangle [
	^ shouldShowDirtyRectangle
]

{ #category : 'accessing' }
RSCanvas >> shouldShowDirtyRectangle: aBoolean [
	shouldShowDirtyRectangle := aBoolean
]

{ #category : 'accessing' }
RSCanvas >> shouldShowEncompassingRectangles [
	^ shouldShowEncompassingRectangles
]

{ #category : 'accessing' }
RSCanvas >> shouldShowEncompassingRectangles: aBoolean [
	shouldShowEncompassingRectangles := aBoolean
]

{ #category : 'debug support' }
RSCanvas >> showDirtyRectangle [
	self shouldShowDirtyRectangle: true
]

{ #category : 'debug support' }
RSCanvas >> showEncompassingRectangles [
	self shouldShowEncompassingRectangles: true
]

{ #category : 'updating' }
RSCanvas >> signalUpdate [
	"Signal a platform signal that the canvas should be refreshed. This is important when some shapes are modified (color or position)."

	host signalUpdate
]

{ #category : 'accessing - computed' }
RSCanvas >> transform: aPoint [
	^ aPoint
]

{ #category : 'dirty areas' }
RSCanvas >> updateDirtyRectangleWith: aRectangle [
	host updateDirtyRectangleWith: aRectangle
]

{ #category : 'accessing' }
RSCanvas >> useMorphicHost [

	host := RSMorphicHost new
		        canvas: self;
		        yourself
]

{ #category : 'camera' }
RSCanvas >> visibleArea: aRectangle [
	self camera zoomToFit: self extent rectangle: aRectangle.
	self signalUpdate
]

{ #category : 'camera' }
RSCanvas >> visibleRectangle [
	"returns the visible rectangle in the space"
	^ self camera visibleRectangle
]

{ #category : 'camera' }
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
