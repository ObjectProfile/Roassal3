"
Bounding shapes have encompassing rectangle or bounding box.
My subclasses are: `RSBitmap`, `RSBox`, `RSCircularShape`, `RSComposite`, `RSLabel`, `RSPieSlice` and `RSSVGPath`

## Instance variables
- `baseRectangle`, the center of this rectangle is `0@0`, base rectangle contains the basic shape without any transformation.
- `matrix` is an instance of `AthensAffineTransform`, this matrix handles scalation, rotation, translation and skew operations.
- `connectedLines`, a collection of lines where this bounding shape is conected. If the shape changes its position, the connected lines will be updated.
- shouldUpdateLines, 
"
Class {
	#name : 'RSBoundingShape',
	#superclass : 'RSShape',
	#traits : 'RSTNode',
	#classTraits : 'RSTNode classTrait',
	#instVars : [
		'baseRectangle',
		'matrix',
		'connectedLines',
		'shouldUpdateLines'
	],
	#category : 'Roassal-Shapes-Bounding',
	#package : 'Roassal-Shapes',
	#tag : 'Bounding'
}

{ #category : 'testing' }
RSBoundingShape class >> isAbstract [
	^ self == RSBoundingShape
]

{ #category : 'accessing' }
RSBoundingShape class >> models: someObjects size: aOneArgBlockOrSymbol [
	"Create a RSGroup made of shapes. Each shape has an element of the argument as model and a size.

For example:
```
c := RSCanvas new.

shapes := RSCircle models: (30 to: 50) size: [ :nb | nb ].

c addAll: shapes.

lines := RSEdgeBuilder line
	canvas: c;
	connectFrom: 30 toAll: (31 to: 50).

lines do: [ :l | l attachPoint: (RSHorizontalAttachPoint new) ].

RSGridLayout on: shapes.
RSLocation new
	above;
	move: shapes first on: shapes allButFirst.
shapes @ RSDraggable.

c @ RSCanvasController.
c open
```
"

	^ someObjects
		  collect: [ :obj |
		  (self model: obj) size: (aOneArgBlockOrSymbol rsValue: obj) ]
		  as: RSGroup
]

{ #category : 'visitor' }
RSBoundingShape >> accept: visitor [
	visitor visitBoundingShape: self
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> addConnectedEdge: anEdge [
	self assert: anEdge isEdge.
	(self connectedEdges includes: anEdge)
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : 'lines' }
RSBoundingShape >> addConnectedLine: aLine [
	self assert: [ aLine isLine ] description: 'Only a line can be added'.
	(self connectedLines includes: aLine)
		ifFalse: [ self connectedLines add: aLine ]
]

{ #category : 'private' }
RSBoundingShape >> allRecursiveConnectedShapesIn: aCollection [
	"Private method"

	"If we already went through me, there is nothing to do"
	(aCollection includes: self) ifTrue: [ ^ self ].

	"Else, we add it and we do the recursion"
	aCollection add: self.
	self incomingShapes do: [ :s | s allRecursiveConnectedShapesIn: aCollection ].
	self outgoingShapes do: [ :s | s allRecursiveConnectedShapesIn: aCollection ]
]

{ #category : 'accessing' }
RSBoundingShape >> baseRectangle [
	^ baseRectangle
]

{ #category : 'accessing - computed' }
RSBoundingShape >> baseRectangleWithBorder [
	| rectangle |
	rectangle := self baseRectangle.
	self hasBorder ifTrue: [ rectangle := rectangle expandBy: border width2 ].
	^ rectangle
]

{ #category : 'transforming' }
RSBoundingShape >> basicTranslateBy: delta [
	self updateLinesOFF.
	self position: self position + delta.
	self updateLinesON
]

{ #category : 'accessing - computed' }
RSBoundingShape >> computeEncompassingRectangle [
	^ self computeEncompassingRectangleFor: self baseRectangleWithBorder
]

{ #category : 'accessing' }
RSBoundingShape >> computeEncompassingRectangleFor: rect [
	^ self computeEncompassingRectangleFor: rect matrix: self matrix
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> connectedEdges [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	^ self connectedLines
]

{ #category : 'lines' }
RSBoundingShape >> connectedLines [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	connectedLines ifNil: [ connectedLines := RSGroup new ].
	^ connectedLines
]

{ #category : 'lines' }
RSBoundingShape >> connectedLines: aCollection [
	connectedLines := aCollection
]

{ #category : 'defaults' }
RSBoundingShape >> defaultExtent [
	^ 10@10
]

{ #category : 'accessing' }
RSBoundingShape >> encompassingRectangle [
	"This is to replace the #explicitRequirement and be faster."

	^ super encompassingRectangle
]

{ #category : 'accessing' }
RSBoundingShape >> extent [
	"This is to replace the #explicitRequirement and be faster."

	^ super extent
]

{ #category : 'accessing' }
RSBoundingShape >> extent: aPoint [
	| oldExtent extent delta |
	
	extent := self baseRectangleWithBorder extent.
	extent = aPoint ifTrue: [ ^ self ].
	self assert: aPoint isPoint.
	oldExtent := extent.
	delta := self hasBorder
		ifTrue: [ border width ]
		ifFalse: [ 0 ].
	baseRectangle := Rectangle floatCenter: 0@0 extent: aPoint - delta.
	self resetBBox; resetPath.
	self announce: [ RSExtentChangedEvent new
		shape: self;
		oldExtent: oldExtent;
		newExtent: extent ]
]

{ #category : 'initialization' }
RSBoundingShape >> fromRectangle: aRectangle [
	"Set the position and extent of the shape, using a rectangle as argument.
For example:
```
c := RSCanvas new.
box := RSBox new.
box fromRectangle: (10 @ 10 corner: 50 @ 40).
c add: box.
c
```
"
	self
		translateTo: aRectangle floatCenter;
		extent: aRectangle extent
]

{ #category : 'geometry' }
RSBoundingShape >> geometry [
	| rect e |
	rect := self encompassingRectangle.
	e := rect extent.
	e = (0@0) ifTrue: [ ^ rect floatCenter asGPoint ].
	^ GRectangle
		origin: rect origin
		corner: rect corner
]

{ #category : 'accessing - computed' }
RSBoundingShape >> globalEncompassingRectangle [
	^ self
		computeEncompassingRectangleFor: self baseRectangle
		matrix: self globalMatrix
]

{ #category : 'matrix' }
RSBoundingShape >> globalMatrix [
	parent ifNil: [ ^ nil ].
	^ parent globalMatrix multiplyBy: matrix
]

{ #category : 'testing' }
RSBoundingShape >> hasEdges [
	^ self hasLines
]

{ #category : 'testing' }
RSBoundingShape >> hasLines [
	"Return true if the shape has any outgoing or incoming line"
	^ connectedLines isNotNil
]

{ #category : 'accessing' }
RSBoundingShape >> height [
	"This is to replace the #explicitRequirement and be faster."

	^ super height
]

{ #category : 'accessing' }
RSBoundingShape >> height: aNumber [
	self extent: self extent x @ aNumber
]

{ #category : 'testing' }
RSBoundingShape >> includesPoint: aPoint [
	"Return true if the provided point is included in the shape"

	"First we check if the encompassingRectangle has the point. If the point is outside, there is not need to transform the point"
	(self encompassingRectangle containsPoint: aPoint)
		ifFalse: [ ^ false ].

	^ self preciseIncludesPoint: aPoint
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> incomingEdges [
	"Return the list of incoming edges from the node"
	connectedLines ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : 'lines' }
RSBoundingShape >> incomingLines [
	"Return the list of incoming edges from the node"
	connectedLines ifNil: [ ^ #() ].
	^ self connectedLines select: [ :e | e to == self ]
]

{ #category : 'accessing - nodes' }
RSBoundingShape >> incomingNodes [
	^ self incomingShapes
]

{ #category : 'lines' }
RSBoundingShape >> incomingShapes [
	"Return the shapes that goes to the shape"
	^ self incomingLines collect: #from
]

{ #category : 'initialization' }
RSBoundingShape >> initialize [
	super initialize.
	self initializeMatrix; updateEdgesON.

	baseRectangle := 0@0 corner: 0@0.
	self extent: self defaultExtent
]

{ #category : 'initialization' }
RSBoundingShape >> initializeMatrix [
	matrix := AthensAffineTransform new
]

{ #category : 'testing' }
RSBoundingShape >> intersects: aRectangle [
	| rect |
	self isInACanvas ifFalse: [ ^ false ].
	rect := self globalEncompassingRectangle.
	^ rect intersects: aRectangle
]

{ #category : 'lines' }
RSBoundingShape >> isDirectlyConnectedTo: aShape [
	connectedLines ifNil: [ ^ false ].
	^ connectedLines anySatisfy: [ :edge | edge to == aShape ]
]

{ #category : 'testing' }
RSBoundingShape >> isNode [
	^ true
]

{ #category : 'matrix' }
RSBoundingShape >> loadIdentity [
	matrix loadIdentity
]

{ #category : 'matrix' }
RSBoundingShape >> matrix [
	^ matrix
]

{ #category : 'matrix' }
RSBoundingShape >> matrix: aMatrix [
	matrix := aMatrix
]

{ #category : 'matrix' }
RSBoundingShape >> matrixDo: aBlock [
	aBlock value: matrix.
	self resetBBox
]

{ #category : 'metrics' }
RSBoundingShape >> numberOfIncomingLines [
	"Return the number of lines incoming to the shape"
	^ self incomingLines size
]

{ #category : 'metrics' }
RSBoundingShape >> numberOfOutgoingLines [
	"Return the number of lines incoming to the shape"
	^ self outgoingLines size
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> outgoingEdges [
	"Return the list of outgoing edges from the node"
	connectedLines ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : 'lines' }
RSBoundingShape >> outgoingLines [
	"Return the list of outgoing edges from the node"
	connectedLines ifNil: [ ^ #() ].
	^ self connectedLines select: [ :e | e from == self ]
]

{ #category : 'accessing - nodes' }
RSBoundingShape >> outgoingNodes [
	^ self outgoingShapes
]

{ #category : 'lines' }
RSBoundingShape >> outgoingShapes [
	"Return the shapes that leaves the shape"
	^ self outgoingLines collect: #to
]

{ #category : 'matrix' }
RSBoundingShape >> position [
	^ matrix translation
]

{ #category : 'matrix' }
RSBoundingShape >> position: aPoint [
	"This method is private. Use #translateTo: instead."
	self
		assert: [ (aPoint x isNaN | aPoint y isNaN) not ]
		description: 'you must provide a real point'.
	matrix translation: aPoint.
	self resetBBox.
	self updateConnectedLines
]

{ #category : 'accessing' }
RSBoundingShape >> positionInCanvas [
	^ self globalMatrix transform: 0@0
]

{ #category : 'copying' }
RSBoundingShape >> postCopy [
	super postCopy.
	self matrix: self matrix copy
]

{ #category : 'testing' }
RSBoundingShape >> preciseIncludesPoint: aPoint [

	"Return true if the provided point is precisily included in the shape. Taking care of the transformation (aka scaling, position, rotation)"

	| invertedPoint |

	invertedPoint := matrix rsInverseTransform: aPoint.
	^ self baseRectangle containsPoint: invertedPoint
]

{ #category : 'actions' }
RSBoundingShape >> remove [
	parent ifNil: [ ^ self ].
	parent removeNode: self.
	self removeConnectedLines.
	super remove
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> removeConnectedEdge: anEdge [
	[  anEdge isEdge ] assert.
	self connectedEdges remove: anEdge ifAbsent: [ ]
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> removeConnectedEdges [
	"Remove all the edges connected (incoming and outgoing)."
	self connectedEdges copy do: [ :edge | edge remove ]
]

{ #category : 'lines' }
RSBoundingShape >> removeConnectedLine: aLine [
	self assert: [  aLine isLine ].
	self connectedLines remove: aLine ifAbsent: [ ]
]

{ #category : 'lines' }
RSBoundingShape >> removeConnectedLines [
	"Remove all the edges connected (incoming and outgoing)."
	self connectedLines copy do: [ :aLine | aLine remove ]
]

{ #category : 'adding' }
RSBoundingShape >> renderOn: aCanvas [
	aCanvas addNode: self
]

{ #category : 'matrix' }
RSBoundingShape >> rotateByDegrees: angle [
	"Rotate the shape. Here is an example:
```
c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
polygon rotateByDegrees: -45.

c add: polygon.
c
```

Another example:
```
c := RSCanvas new.

(0 to: 90 count: 10) do: [ :rotation |
	lbl := RSLabel text: 'Hello world'.
	lbl color: Color gray translucent.
	lbl rotateByDegrees: rotation.
	lbl @ RSHighlightable red.
	lbl translateTopLeftTo: 0 @ 0.
	c add: lbl
	 ].
c @ RSCanvasController.
c open
```
	"
	matrix rotateByDegrees: angle.
	self resetBBox.
]

{ #category : 'matrix' }
RSBoundingShape >> rotateByRadians: angle [
	"Rotate the shape. Here is an exanmple:
-=-=-=
c := RSCanvas new.
c add: (RSBox new
	size: 10;
	rotateByRadians: Float pi / 3;
	yourself).
c
-=-=-=
	"
	matrix rotateByRadians: angle
]

{ #category : 'matrix' }
RSBoundingShape >> scale [
	^ matrix scale
]

{ #category : 'matrix' }
RSBoundingShape >> scaleBy: scale [
	"Scale the shape. For example:

```
c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
polygon rotateByDegrees: -45.
polygon scaleBy: 4.
c add: polygon.
c
```
	"
	matrix scaleBy: scale.
	self resetBBox
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> shouldUpdateEdges [
	"Moving a shape around usually involve recomputing the original of the connected egdes. This may be disabled. This method indicates whether edges are updated when the shape is moved."
	^ shouldUpdateLines and: [ connectedLines isNotNil ]
]

{ #category : 'testing' }
RSBoundingShape >> shouldUpdateLines [
	"Moving a shape around usually involve recomputing the original of the connected egdes. This may be disabled. This method indicates whether edges are updated when the shape is moved."
	^ shouldUpdateLines and: [ connectedLines isNotNil ]
]

{ #category : 'accessing' }
RSBoundingShape >> size: anInteger [
	"Set the size of the shape by providing a number."
	self extent: anInteger asPoint
]

{ #category : 'matrix' }
RSBoundingShape >> transform: aPoint [
	"useful for attachpoints"
	^ matrix transform: aPoint
]

{ #category : 'actions' }
RSBoundingShape >> translateBottomLeftTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top left corner'.
c add: lbl.
lbl translateBottomLeftTo: 0 @ 0.

dot := RSCircle new.
c add: dot.
c zoomToFit.
c open
```

"
	self translateTo: aPositionAsPoint + ((self extent / 2) * (1 @ -1))
]

{ #category : 'actions' }
RSBoundingShape >> translateBottomRightTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top left corner'.
c add: lbl.
lbl translateBottomRightTo: 0 @ 0.

dot := RSCircle new.
c add: dot.
c zoomToFit.
c open
```

"
	self translateTo: aPositionAsPoint + ((self extent / 2) * (-1 @ -1))
]

{ #category : 'actions' }
RSBoundingShape >> translateMiddleRightTo: aPositionAsPoint [
	"Translate the shape to make the middle right position at a given position

```
c := RSCanvas new.

center := RSEllipse new size: 2; color: Color red.
c add: center.
center translateTo: 0 @ 0.

lbl := RSLabel text: 'Middle right corner'.
c add: lbl.
lbl translateMiddleRightTo: 0 @ 0.
c @ RSCanvasController.
c open
```

"
	self translateTo: aPositionAsPoint - ((self extent x / 2) @ 0)
]

{ #category : 'actions' }
RSBoundingShape >> translateTopLeftTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top left corner'.
c add: lbl.
lbl setAsFixed.
lbl translateTopLeftTo: 0 @ 0.
c open
```

"
	self translateTo: aPositionAsPoint + (self extent / 2)
]

{ #category : 'actions' }
RSBoundingShape >> translateTopRightTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top right corner'.
c add: lbl.
lbl translateTopRightTo: 0 @ 0.

dot := RSCircle new.
c add: dot.
c zoomToFit.
c open
```

"
	self translateTo: aPositionAsPoint + ((self extent / 2) * (-1 @ 1))
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> updateConnectedEdges [
	self shouldUpdateEdges
		ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ]
]

{ #category : 'lines' }
RSBoundingShape >> updateConnectedLines [
	self shouldUpdateLines
		ifFalse: [ ^ self ].
	self connectedLines do: [ :line | line update ]
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> updateEdgesOFF [
	shouldUpdateLines := false
]

{ #category : 'edges - deprecated' }
RSBoundingShape >> updateEdgesON [
	shouldUpdateLines := true
]

{ #category : 'lines' }
RSBoundingShape >> updateLinesOFF [
	shouldUpdateLines := false
]

{ #category : 'lines' }
RSBoundingShape >> updateLinesON [
	shouldUpdateLines := true
]

{ #category : 'accessing' }
RSBoundingShape >> width [
	"This is to replace the #explicitRequirement and be faster."

	^ super width
]

{ #category : 'accessing' }
RSBoundingShape >> width: aNumber [
	self extent: aNumber @ self extent y
]

{ #category : 'matrix' }
RSBoundingShape >> x: aNumber [
	"Set the x position"
	self position: aNumber @ self position y
]

{ #category : 'matrix' }
RSBoundingShape >> y: aNumber [
	"Set the y position"
	self position: self position x @ aNumber
]
