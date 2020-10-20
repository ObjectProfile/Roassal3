"
I am a composite shapes. I can therefore contain other shapes.

Here is a simple example:
-=-=-=
c := RSCanvas new.

box := RSBox new width: 40; height: 10; color: Color blue.
label := RSLabel new text: 'Hello Roassal3'.
RSLocation new above; move: box on: label.
composite := RSComposite new.
composite shapes: { label . box }.
composite @ RSDraggable.

c add: composite.
c
-=-=-=

A composite can also have a background color. Simply use #color: for this:
-=-=-=
c := RSCanvas new.

box := RSBox new width: 40; height: 10; color: Color blue.
label := RSLabel new text: 'Hello Roassal3'.
RSLocation new above; move: box on: label.
composite := RSComposite new.
composite color: Color gray.
composite shapes: { label . box }.
composite @ RSDraggable.

c add: composite.
c
-=-=-=

A padding describes a space between the border of the composite element and the inner shapes. It can be adjusted using the message #padding:

-=-=-=
c := RSCanvas new.

box := RSBox new width: 40; height: 10; color: Color blue.
label := RSLabel new text: 'Hello Roassal3'.
RSLocation new above; move: box on: label.
composite := RSComposite new.
composite color: Color gray.
composite shapes: { label . box }.
composite @ RSDraggable.
composite padding: 10.

c add: composite.
c
-=-=-=

Inner nodes can be layouted:
-=-=-=
classes := RSObject withAllSubclasses.

c := RSCanvas new.

classes do: [ :cls |
	label := RSLabel new text: cls name.
	methods := 
		cls methods collect: [ :m |
			RSBox new model: m; size: m sourceCode size sqrt; color: Color blue ] as: RSGroup.
	RSGridLayout on: methods.
	methods @ RSPopup.
	RSLocation new above; move: label on: methods.
	composite := RSComposite new.
	composite color: Color gray.
	composite shapes: { label }, methods.
	composite @ RSDraggable.
	composite padding: 10.
	c add: composite.
].

RSFlowLayout on: c shapes.

c @ RSControlsCanvas
-=-=-=

Lines can be added between composite. Here is an example:
-=-=-=
classes := RSObject withAllSubclasses.

c := RSCanvas new.

classes do: [ :cls |
	label := RSLabel new text: cls name.
	methods := 
		cls methods collect: [ :m |
			RSBox new model: m; size: m sourceCode size sqrt; color: Color blue ] as: RSGroup.
	RSGridLayout on: methods.
	methods @ RSPopup.
	RSLocation new above; move: label on: methods.
	composite := RSComposite new.
	composite model: cls.
	composite color: Color gray.
	composite shapes: { label }, methods.
	composite @ RSDraggable.
	composite padding: 10.
	c add: composite.
].

RSEdgeBuilder orthoVertical
	canvas: c;
	withVerticalAttachPoint;
	connectFrom: #superclass.

RSTreeLayout on: c nodes.

c @ RSControlsCanvas
-=-=-=
"
Class {
	#name : #RSComposite,
	#superclass : #RSBoundingShape,
	#traits : 'RSTContainer',
	#classTraits : 'RSTContainer classTrait',
	#instVars : [
		'nodes',
		'edges',
		'children'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #adding }
RSComposite >> addBasicShape: aShape [
	self shapes add: aShape
]

{ #category : #adding }
RSComposite >> addFixedShape: aShape [
	self error: 'Composite can not add a fixed shape'
]

{ #category : #adding }
RSComposite >> addShape: aShape [
	"Add a shape in a composite shape"
	aShape addedIn: self
]

{ #category : #adding }
RSComposite >> addShape: aShape before: otherShape [ 
	"Add a shape in a composite shape"
	aShape addedIn: self.
	self children
		remove: aShape;
		add: aShape before: otherShape
]

{ #category : #public }
RSComposite >> adjustToChildren [
"Recompute the encompassing rectangle of the composite shape from the positio of the children. 

In case one wishes to have a padding in the composite, the method #padding: must be called _after_ calling #adjustToChildren

Consider the following example:
```Smalltalk
box := RSBox new size: 20.
circle := RSEllipse new size: 20.
g := RSGroup new.
g add: box; add: circle.
composite := g asShape.
composite extent. '=> (20.0@20.0)'

RSVerticalLineLayout on: g.
composite extent. '=> (20.0@20.0)'
composite adjustToChildren.
composite extent '=> (20.0@50.0)'
```
"
	| rect delta |
	children ifNil: [ ^ self ].
	rect := children encompassingRectangle.
	delta := rect floatCenter negated.
	
	children do: [ :s | s basicTranslateBy: delta ].
	self 
		extent: rect extent;
		translateTo: delta negated.
]

{ #category : #accessing }
RSComposite >> camera [
	^ parent camera
]

{ #category : #accessing }
RSComposite >> children [
	^ children ifNil: [ children := RSGroup new ]
]

{ #category : #accessing }
RSComposite >> children: aRSGroup [
	"
	create a groups of elements or trachel shapes, then added them to this composite shape
	this method changes the position of the shapes and set the position of this composite shape
	to the center of the encompassingRectangle.
	"
	aRSGroup copy do: [ :s | 
		s isInACanvas 
			ifTrue: [ s remove ] ].
	self addAll: aRSGroup.
	self adjustToChildren.

	
]

{ #category : #'looking up shapes' }
RSComposite >> deepShapesFromModels: someObjects result: result [
	"Private method"
	(someObjects includes: self model) ifTrue: [ result add: self ].
	self nodes do: [ :c | c deepShapesFromModels: someObjects result: result ]
]

{ #category : #testing }
RSComposite >> hasChildren [
	^ children notNil and: [ children isNotEmpty ]
]

{ #category : #initialization }
RSComposite >> initialize [
	super initialize.
	self paint: nil.
	self resetPath.
	
]

{ #category : #accessing }
RSComposite >> padding: anObject [
	"Set the padding, i.e., the distance between the nested shapes and the outter composite shape.
The argument, anObject can be a number, a point or Margin. 

IMPORTANT:
- The shapes must be added in the composite before calling #padding:
- The padding must be set after having performed #adjustToChildren
	
Here is an example of usage:
```Smalltalk
box := RSBox new
    color: Color blue translucent;
    fromRectangle: ((-38.5@ -20.0) corner: (38.5@20.0));
    yourself.
label := RSLabel new
    text: 'Smalltalk';
    yourself.
g := RSGroup new.
g add: box.
g add: label.
composite := g asShape.
composite padding: 20.
composite color: Color red.

c := RSCanvas new.
c add: composite.

c
```
	"
	
	| margin rect center temp |
	temp := children 
		ifNil: [ RSGroup new: 0 ]
		ifNotNil: [children].
	margin := anObject asMargin. 
	rect := temp encompassingRectangle.
	rect := margin expandRectangle: rect.
	self extent: rect extent.
	
	(center := rect floatCenter) = (0@0) ifTrue: [ ^ self ].
	center := center negated.
	temp do: [ :s | s basicTranslateBy: center ].
]

{ #category : #private }
RSComposite >> privateEdges [
	^ edges
]

{ #category : #private }
RSComposite >> privateEdges: aRSGroup [
	edges := aRSGroup
]

{ #category : #private }
RSComposite >> privateNodes [
	^ nodes
]

{ #category : #private }
RSComposite >> privateNodes: aRSGroup [
	nodes := aRSGroup
]

{ #category : #private }
RSComposite >> privateShapes [
	^ children
]

{ #category : #private }
RSComposite >> privateShapes: aCollection [
	children := aCollection
]

{ #category : #actions }
RSComposite >> pushBack: aShape [
	"Put a shape behind all other shapes"
	children
		remove: aShape;
		addFirst: aShape
]

{ #category : #actions }
RSComposite >> pushFront: shape [
	children 
		remove: shape ifAbsent: [];
		addLast: shape. 
	
]

{ #category : #removing }
RSComposite >> removeShape: shape [
	| evt |
	children remove: shape.
	shape parent: nil.
	evt := RSShapeRemovedEvent new shape: shape.
	self announce: evt.
	shape announce: evt.
	
]

{ #category : #path }
RSComposite >> resetPath [
	path := baseRectangle
]

{ #category : #path }
RSComposite >> sessionChanged [
	"This method releases all the native graphical resources. This method is typically invoked when starting a Pharo image with a visualization that was previously open"
	self resetPath.
	children ifNil: [ ^ self ].
	children do: #sessionChanged
]

{ #category : #'accessing - computed' }
RSComposite >> shapeWithAction: eventClass forPosition: position [
	| res pos |
	pos := self matrix rsInverseTransform: position.
	self shapes reverseDo: [ :s |
		res := s shapeWithAction: eventClass forPosition: pos.
		res ifNotNil: [ ^ res] ].
	
	^ super shapeWithAction: eventClass forPosition: position.
]

{ #category : #'accessing - computed' }
RSComposite >> shapeWithActionForPosition: position [
	| res pos |
	pos := self matrix rsInverseTransform: position.
	self shapes reverseDo: [ :s |
		res := s shapeWithActionForPosition: pos.
		res ifNotNil: [ ^ res] ].
	^ super shapeWithActionForPosition: position.
]

{ #category : #accessing }
RSComposite >> shapes [
	^ self children
]

{ #category : #accessing }
RSComposite >> shapes: aRSGroup [
	self children: aRSGroup
]

{ #category : #edges }
RSComposite >> updateConnectedEdges [
	"Update the edge connected to elements contained in the composite. This happens when a shape is drag and dropped. For example:
	
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

c add: (RSLabel new text: 'I am connected to'; model: 0).
c shapes first translateBy: -50 @ 50.

g := RSGroup new.
g add: (RSLabel new text: '1'; model: 1).
g add: (RSLabel new text: '2'; model: 2).
RSHorizontalLineLayout on: g.
composite := g asShape.
composite color: Color lightBlue.
c add: composite.

c shapes @ RSDraggable.

c add: (RSLine new color: Color red; from: c shapes first; to: g first).
c add: (RSLine new color: Color red; from: c shapes first; to: g second).
c @ RSCanvasController
-=-=-=-=-=-=-=-=-=
"
	self shouldUpdateEdges 
		ifTrue: [ connectedEdges do: [ :edge | edge update ] ].
	self children do: [ :child | 
		child isNode
			ifTrue: [ child updateConnectedEdges ] ]
]
