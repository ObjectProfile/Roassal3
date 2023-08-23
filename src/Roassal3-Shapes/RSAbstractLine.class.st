"
Lines in roassal can be: straight lines and bezier lines. Here there are som subclasses: `RSLine`, `RSArrowedLine`, `RSBezier`, `RSPolyline`, but you can define more types of lines.

## Examples
```
line := RSLine new.
line startPoint: 0@0.
line endPoint: 100@100.

bezier := RSBezier new.
bezier controlPoints: { 0 @ 0. 100@100. 200@0 }.
```
More examples:
```
RSShapeExamples new example35Lines.
RSBasicShapeExamples new example12BasicLine.
RSBasicShapeExamples new example31BorderAttachPointWithOffset.
```

## Canvas
Lines interact directly with the canvas(`RSCanvas`), when you add it to the canvas you can access all lines with method `lines`.

There are two groups of lines in roassal, lines with 2 control points and lines with several control points.

## Conection with nodes
Lines can be conected to a node, an instance of `RSBoundingShape`.

```
x := RSBox new.
y := RSBox new.
line from: x.
line to: y.
```

Then if you move one box, the line will update its position.

## Attach Points
In order to calculate the line position related to one connected box, lines use instances of `RSAttachPoint`. An attach point only works with `from:` or `to:` methods.
```
line attachPoint: RSVerticalAttach new.
```
In the previous script vertical attach point will compute vertical control points for the `from:` and `to:` shapes
## Markers
Lines in roassal also have markers, it is a kind of decoration for lines. Check this class `RSTMarkeable`. In a line you can put a decoration for each control point. This decoration is `markerStart:` for the first control point, `markerEnd:` for the last control point. and `markerMiddle:` for middle control points.
Lines uses `RSMarker`
```
shape := RSShapeFactory triangle.
shape extent: 10@10.
line markerEnd: shape asMarker.
```

"
Class {
	#name : #RSAbstractLine,
	#superclass : #RSShape,
	#traits : 'RSTMarkeable + RSTPositionable',
	#classTraits : 'RSTMarkeable classTrait + RSTPositionable classTrait',
	#instVars : [
		'attachPoint',
		'from',
		'to',
		'markers'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #testing }
RSAbstractLine class >> isAbstract [
	^ self =  RSAbstractLine
]

{ #category : #'instance creation' }
RSAbstractLine class >> newFrom: aShape to: anotherShape [
	^ self new
		from: aShape;
		to: anotherShape;
		yourself
]

{ #category : #adding }
RSAbstractLine >> accept: visitor [
	visitor visitLine: self
]

{ #category : #'attach point' }
RSAbstractLine >> attachPoint [
	^ attachPoint
]

{ #category : #'attach point' }
RSAbstractLine >> attachPoint: anAttachPoint [
	attachPoint := anAttachPoint
]

{ #category : #testing }
RSAbstractLine >> basicIncludesPoint: aPoint [
	^ false
]

{ #category : #accessing }
RSAbstractLine >> basicTranslateBy: delta [
	^ self subclassResponsibility
]

{ #category : #'style - cap' }
RSAbstractLine >> capButt [
	self border capButt
]

{ #category : #'style - cap' }
RSAbstractLine >> capRound [
	self border capRound
]

{ #category : #'style - cap' }
RSAbstractLine >> capSquare [
	self border capSquare
]

{ #category : #accessing }
RSAbstractLine >> color [
	^ self strokePaint
]

{ #category : #accessing }
RSAbstractLine >> color: aColor [
	self strokePaint: (Color colorFrom: aColor)
]

{ #category : #'accessing-computed' }
RSAbstractLine >> colorFromString: aString [
	| colorList |
	colorList := {
		#r. Color red. 
		#g. Color green.
		#b. Color blue.
		#c. Color cyan.
		#m. Color magenta.
		#y. Color yellow.
		#k. Color black.
		#w. Color white.
	}.
	colorList pairsDo: [ 
		:colorSymbol :colorValue |
		(aString includesSubstring: colorSymbol) ifTrue: [ ^colorValue  ]].
	^ self color. "Default case, when it isn't found the color in the list"
]

{ #category : #accessing }
RSAbstractLine >> computeEncompassingRectangle [
	| cp |
	cp := self controlPoints.
	^ cp
			ifEmpty: [ 0@0 corner: 0@0 ]
			ifNotEmpty: [ Rectangle encompassing: cp ]
]

{ #category : #accessing }
RSAbstractLine >> controlPoints [
	^ self subclassResponsibility
]

{ #category : #'style - dashes' }
RSAbstractLine >> dashArray: arrayOfNumbers [
	self border dashArray: arrayOfNumbers
]

{ #category : #'style - dashes' }
RSAbstractLine >> dashed [
	self dashArray: #(4)
]

{ #category : #accessing }
RSAbstractLine >> endPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> endPoint: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> format: aString [
	"Format for lines a shortcut to define a line styles, or markers

	For markers use
	'o' - circle
	'^' - arrow
	's' - square
	'p' - pentagon
	'h' - hexagon
	'+' - plus
	'd' - diamond
	'*' - star

	For stroke styles use:
	'--' dashed line.
	'-.' dashed line with small line then point
	'.' dashed line with points

	Example:
```
| canvas |
canvas := RSCanvas new.
canvas add: (RSLine new
	startPoint: 0@0;
	endPoint: 100@0;
	fmt:'-.*';
	color: Color red;
	yourself).
canvas @ RSCanvasController.
canvas open
````
	 "
	self color: (self colorFromString: aString).
	(RSShapeFactory shapeFromString: aString) ifNotNil: [ :markerShape |
		markerShape
			size: self border width * self markerSizeScale;
			color: self color.
		self marker: markerShape ].
	(RSStrokeStyle fromString: aString) ifNotNil: [ :style |
		self border style: style ]
]

{ #category : #accessing }
RSAbstractLine >> from [
	^ from
]

{ #category : #accessing }
RSAbstractLine >> from: aShapeOrAPoint [
	"Set the end point of the line"
	from := self setAnchor: from shape: aShapeOrAPoint
]

{ #category : #accessing }
RSAbstractLine >> includedRadius [
	^ self border width / 2
]

{ #category : #testing }
RSAbstractLine >> includesPoint: aPoint [
	^ self hasBorder and: [ (self basicIncludesPoint: aPoint) or: [ self markersIncludesPoint: aPoint ] ]
]

{ #category : #initialization }
RSAbstractLine >> initialize [
	super initialize.
	self
		withBorder;
		noPaint;
		withCenteredAttachPoint
]

{ #category : #testing }
RSAbstractLine >> intersects: aRectangle [
	| rect res globalMatrix |
	self isInACanvas ifFalse: [ ^ false ].
	globalMatrix := self parent globalMatrix.
	rect := self
		computeEncompassingRectangleFor: self encompassingRectangle
		matrix: globalMatrix.
	res := rect intersects: aRectangle.
	res ifTrue: [ ^ true ].
	self hasMarkers ifFalse: [ ^ false ].
	self markerShapesInPositionDo: [ :m |
		rect := self
			computeEncompassingRectangleFor: m shape encompassingRectangle
			matrix: globalMatrix.
		(rect intersects: aRectangle) ifTrue: [ ^ true ].
		 ].
	^ false
]

{ #category : #testing }
RSAbstractLine >> isControlPointsLine [
	^ false
]

{ #category : #testing }
RSAbstractLine >> isEdge [
	^ true
]

{ #category : #testing }
RSAbstractLine >> isLine [
	^ true
]

{ #category : #'style - join' }
RSAbstractLine >> joinBevel [
	self border joinBevel
]

{ #category : #'style - join' }
RSAbstractLine >> joinMiter [
	self border joinMiter
]

{ #category : #'style - join' }
RSAbstractLine >> joinRound [
	self border joinRound
]

{ #category : #accessing }
RSAbstractLine >> markerSizeScale [
	^ 4
]

{ #category : #'event handling' }
RSAbstractLine >> notifyExtentChanged [
	self announce: [ RSExtentChangedEvent new
		shape: self;
		oldExtent: nil;
		newExtent: self controlPoints first - self controlPoints last ]
]

{ #category : #accessing }
RSAbstractLine >> position [
	^ self encompassingRectangle floatCenter
]

{ #category : #copying }
RSAbstractLine >> postCopy [
	super postCopy.
	self border: self border copy
]

{ #category : #'accessing - markers' }
RSAbstractLine >> privateMarkers [
	^ markers
]

{ #category : #'accessing - markers' }
RSAbstractLine >> privateMarkers: array [
	markers := array
]

{ #category : #adding }
RSAbstractLine >> remove [
	parent ifNil: [ ^ self ].
	parent removeEdge: self.
	self
		removeFromParent: to;
		removeFromParent: from.
	super remove
]

{ #category : #private }
RSAbstractLine >> removeFromParent: aShape [
	aShape ifNil: [ ^ self ].
	aShape isPoint ifTrue: [ ^ self ].
	aShape connectedLines remove: self ifAbsent: [  ]
]

{ #category : #adding }
RSAbstractLine >> renderOn: aCanvas [
	aCanvas addEdge: self.
	self update
]

{ #category : #path }
RSAbstractLine >> resetPath [
	super resetPath.
	self resetBBox
]

{ #category : #path }
RSAbstractLine >> sessionChanged [
	"This method releases all the native graphical resources. This method is typically invoked when starting a Pharo image with a visualization that was previously open"
	self resetPath.
	self hasMarkers ifFalse: [ ^ self ].
	self markersDo: [ :mark | mark shape sessionChanged ]
]

{ #category : #private }
RSAbstractLine >> setAnchor: ref shape: anObject [
	ref ifNotNil: [ ref removeConnectedLine: self ].
	anObject isPoint ifFalse: [ anObject addConnectedLine: self ].
	^ anObject
]

{ #category : #accessing }
RSAbstractLine >> startPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> startPoint: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> strokeColor: aColor [
	self strokePaint: aColor
]

{ #category : #accessing }
RSAbstractLine >> strokePaint [
	^ self border paint
]

{ #category : #accessing }
RSAbstractLine >> strokePaint: aPaint [
	self border paint: aPaint.
	self markersDo: [:m | m shape paint: aPaint ]
]

{ #category : #accessing }
RSAbstractLine >> to [
	^ to
]

{ #category : #accessing }
RSAbstractLine >> to: aShapeOrAPoint [
	"Set the end point of the line"
	to := self setAnchor: to shape: aShapeOrAPoint
]

{ #category : #update }
RSAbstractLine >> update [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> width: aNumber [
	self border width: aNumber
]

{ #category : #'attach point' }
RSAbstractLine >> withBorderAttachPoint [
	self attachPoint: RSBorderAttachPoint new
]

{ #category : #'attach point' }
RSAbstractLine >> withCenteredAttachPoint [
	self attachPoint: RSCenteredAttachPoint new
]

{ #category : #'attach point' }
RSAbstractLine >> withHorizontalAttachPoint [
	self attachPoint: RSHorizontalAttachPoint new
]

{ #category : #'attach point' }
RSAbstractLine >> withVerticalAttachPoint [
	self attachPoint: RSVerticalAttachPoint new
]
