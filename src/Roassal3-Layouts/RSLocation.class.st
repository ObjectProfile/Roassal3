"
<keyClass>
`RSLocation` locates shapes with respect to other shapes. Shapes can be positioned in a sticky fashion or not. Being sticky means whether the base shapes ""drag"" the sitcky shapes when dragged. `RSLocation` iteratively builds constraint for moving and positioning a shape on top of another one.

*Responsibility*: locate permanently or not some shapes with respect to other shapes.

*Collaborators*: closely interact with `RSShape`, `RSExtentChangedEvent`, and `RSPositionChangedEvent`

*Variables*:
- `offset`: offset between the positioned shape and the base shape
- `orientation`: a value that could be -1, 0, 1 indicating the orientation of the location
- `direction`: a point indicating the direction of the lcoation

*Example*:
Here is a simple example:
```Smalltalk
c := RSCanvas new.

box1 := RSBox new size: 50; color: Color gray translucent.
box2 := RSBox new size: 30; color: Color gray translucent.
box1 @ RSDraggable.
box2 @ RSDraggable.
c add: box1; add: box2.

box1 translateBy: 150 @ -40.

label := RSLabel new text: 'Move the mouse above me'.
c add: label.
RSLocation new 
	above;
	stick: label on: box1.
c
```


```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape, drag me').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	bottom;
	outer;
	right;
	offset: 20;
	stick: redShape on: baseShape.
""Try changing stick:on: by move:on. Replacing bottom by top""
c
```

A more complex example:

```Smalltalk
v := RSCanvas new.

classes := Collection withAllSubclasses.
boxes := classes collect: [ :cls |
	RSBox new
		width: (cls instVarNames size * 5 max: 5);
		height: (cls numberOfMethods max: 5);
		model: cls
] as: RSGroup.

boxes @ RSDraggable.
v addAll: boxes.

RSEdgeBuilder orthoVertical
	canvas: v;
	attachPoint: RSVerticalAttachPoint new;
	shapes: boxes;
	connectFrom: #superclass.

boxes do: [ :b |
	| t |
	t := RSLabel new height: 2; text: b model name.
	v add: t.
	RSLocation new
		offset: 1;
		above; center;
		stick: t on: b.
].

RSTreeLayout on: boxes.
v @ RSCanvasController.
v open
```
"
Class {
	#name : #RSLocation,
	#superclass : #RSObject,
	#instVars : [
		'offset',
		'orientation',
		'direction',
		'fixedX',
		'fixedY'
	],
	#category : #'Roassal3-Layouts-PositionAndResize'
}

{ #category : #'as yet unclassified' }
RSLocation class >> move: aShapeOrAGroup1 above: aShapeOrAGroup2 [
	self new above; move: aShapeOrAGroup1 on: aShapeOrAGroup2
]

{ #category : #'public - positioning shorcuts' }
RSLocation >> above [ 
	self top; outer.
]

{ #category : #'public - positioning shorcuts' }
RSLocation >> below [ 
	self bottom; outer
]

{ #category : #'public - modifiers' }
RSLocation >> border [
	orientation := 0
]

{ #category : #'public - positioning' }
RSLocation >> bottom [
	"Locate the shape at the bottom of the base shape.
For example:
```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	bottom;
	outer;
	right;
	move: redShape on: baseShape.
c
```
	"
	fixedY := #bottom.
	direction := direction x @ -1.
]

{ #category : #'public - positioning' }
RSLocation >> center [
	fixedX := [ :rec | rec floatCenter x ].
	direction := 0 @ direction y
]

{ #category : #private }
RSLocation >> computePosition: movableShape on: fixedShape [
	^ movableShape extent / 2 * orientation * direction + (self parentPosition: fixedShape) + offset.
]

{ #category : #initialization }
RSLocation >> initialize [
	super initialize.
	direction := 0 @ 0.
	self
		offset: 0;
		inner;
		middle;
		center
]

{ #category : #'public - modifiers' }
RSLocation >> inner [
	orientation := 1
]

{ #category : #'public - positioning' }
RSLocation >> left [
	"Locate the shape on the left of the base shape.
For example:
```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	above;
	left;
	move: redShape on: baseShape.
c
```"
	fixedX := #left.
	direction := 1@ direction y
]

{ #category : #'public - positioning' }
RSLocation >> middle [
	"Locate the shape in the middle of the base shape.
For example:
```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	middle;
	above;
	move: redShape on: baseShape.
c
```
	"
	fixedY := [ :r | r floatCenter y ].
	direction := direction x @ 0
]

{ #category : #'public - executing' }
RSLocation >> move: movableShape on: baseShape [
	"Utility method"
	movableShape translateTo: (self computePosition: movableShape on: baseShape).
]

{ #category : #'public - modifiers' }
RSLocation >> offset [
	^ offset
]

{ #category : #'public - modifiers' }
RSLocation >> offset: aNumber [
	"Let an offset between the positioned shape and the base shape.
	
For example
```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	bottom;
	outer;
	right;
	offset: 20;
	move: redShape on: baseShape.
c
```"
	offset := aNumber asPoint
]

{ #category : #'public - modifiers' }
RSLocation >> outer [
	orientation := -1
]

{ #category : #private }
RSLocation >> parentPosition: fixedShape [
	| rec |
	rec := fixedShape.
	rec isRectangle ifFalse:  [ rec := rec encompassingRectangle ] .
	^ (fixedX value: rec)@ (fixedY value: rec).
]

{ #category : #'public - positioning' }
RSLocation >> right [
	"Locate the shape on the right of the base shape.
For example:
```Smalltalk
c := RSCanvas new.

g := RSGroup new.
g add: (RSLabel new text: 'Base shape').
baseShape := g asShape adjustToChildren.
baseShape color: #lightBlue.
baseShape @ RSDraggable.
c add: baseShape.

redShape := RSBox new extent: 60 @ 30; color: #red.
c add: redShape.

RSLocation new
	above;
	right;
	move: redShape on: baseShape.
c
```"
	fixedX := #right.
	direction := -1 @ direction y.
]

{ #category : #'public - executing' }
RSLocation >> stick: movableShape on: baseShape [
	| block |
	block := [ self move: movableShape on: baseShape ].
	block value.
	baseShape 
		when: RSExtentChangedEvent do: block;
		when: RSPositionChangedEvent do: block.
]

{ #category : #'public - positioning' }
RSLocation >> top [
	fixedY := #top.
	direction := direction x @ 1
]
