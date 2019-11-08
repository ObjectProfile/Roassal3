"
I am iteratively buildable constraint for moving and positioning an element on top of another one.

!! Usage

The order of configuration message sends is irrelevant, only the last of a group will be used.

Here is an example:
```Smalltalk
v := RSView new.

classes := Collection withAllSubclasses.
boxes := RSShapeBuilder box
				width: [ :cls | cls instVarNames size * 5 max: 5 ];
				height: [ :cls | cls numberOfMethods max: 5 ];
				elementsOn: classes.
boxes @ RSDraggable.
v addAll: boxes.

RSEdgeBuilder orthoVertical
	view: v;
	attachPoint: RSVerticalAttachPoint new;
	elements: boxes;
	connectFrom: #superclass.

boxes do: [ :b |
	| t |
	t := RSShapeBuilder label height: 2; text: #name; elementOn: b model.
	v add: t.
	RSLocate new
		offset: 1;
		above; center;
		stick: t on: b.
].

RSTreeLayout on: boxes.
v @ RSControlsView.
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
	#category : #'Roassal3-Utils-PositionAndResize'
}

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
	fixedY := #bottom.
	direction := direction x@ -1.
]

{ #category : #'public - positioning' }
RSLocation >> center [
	fixedX := [:rec | rec rsCenter x].
	direction := 0@ direction y
]

{ #category : #private }
RSLocation >> computePosition: movableShape on: fixedShape [
	^ movableShape extent / 2 * orientation * direction + (self parentPosition: fixedShape) + offset.
]

{ #category : #initialization }
RSLocation >> initialize [
	super initialize.
	direction := 0@0.
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
	fixedX := #left.
	direction := 1@ direction y
]

{ #category : #'public - positioning' }
RSLocation >> middle [
	fixedY := [ :r | r rsCenter y ].
	direction := direction x @ 0
]

{ #category : #'public - executing' }
RSLocation >> move: movableShape on: fixShape [
	movableShape translateTo: (self computePosition: movableShape on: fixShape).
]

{ #category : #'public - modifiers' }
RSLocation >> offset [
	^ offset
]

{ #category : #'public - modifiers' }
RSLocation >> offset: aNumber [
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
	fixedX := #right.
	direction := -1@direction y.
]

{ #category : #'public - executing' }
RSLocation >> stick: movableShape on: fixedShape [
	| block |
	block := [ self move: movableShape on: fixedShape ].
	block value.
	fixedShape 
		when: RSExtentChangedEvent do: block;
		when: RSPositionChangedEvent do: block.
]

{ #category : #'public - positioning' }
RSLocation >> top [
	fixedY := #top.
	direction := direction x @ 1
]
