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
		padding: 1;
		fix: b;
		movable: t;
		above; center; stick.
].

RSTreeLayout on: boxes.
v @ RSControlsView.
v open
```
"
Class {
	#name : #RSLocate,
	#superclass : #RSObject,
	#instVars : [
		'padding',
		'orientation',
		'direction',
		'fixedX',
		'fixedY'
	],
	#category : #'Roassal3-Utils-PositionAndResize'
}

{ #category : #'public - positioning shorcuts' }
RSLocate >> above [ 
	self top; outer.
]

{ #category : #'public - positioning shorcuts' }
RSLocate >> below [ 
	self bottom; outer
]

{ #category : #'public - modifiers' }
RSLocate >> border [
	orientation := 0
]

{ #category : #'public - positioning' }
RSLocate >> bottom [
	fixedY := #bottom.
	direction := direction x@ -1.
]

{ #category : #'public - positioning' }
RSLocate >> center [
	fixedX := [:rec | rec rsCenter x].
	direction := 0@ direction y
]

{ #category : #private }
RSLocate >> computePosition: movableElement [
	^ movableElement extent / 2 + padding * orientation * direction + self parentPosition.
]

{ #category : #private }
RSLocate >> computePosition: movableElement on: fixedElement [
	^ movableElement extent / 2 + padding * orientation * direction + (self parentPosition: fixedElement).
]

{ #category : #initialization }
RSLocate >> initialize [
	super initialize.
	direction := 0@0.
	self
		padding: 0;
		inner;
		middle;
		center
]

{ #category : #'public - modifiers' }
RSLocate >> inner [
	orientation := 1
]

{ #category : #'public - positioning' }
RSLocate >> left [
	fixedX := #left.
	direction := 1@ direction y
]

{ #category : #'public - positioning' }
RSLocate >> middle [
	fixedY := [ :r | r rsCenter y ].
	direction := direction x @ 0
]

{ #category : #'public - executing' }
RSLocate >> move: movableElement on: fixElement [
	movableElement translateTo: (self computePosition: movableElement on: fixElement).
]

{ #category : #'public - modifiers' }
RSLocate >> outer [
	orientation := -1
]

{ #category : #'public - modifiers' }
RSLocate >> padding [
	^ padding
]

{ #category : #'public - modifiers' }
RSLocate >> padding: aNumber [
	padding := aNumber asPoint
]

{ #category : #private }
RSLocate >> parentPosition: fixedElement [
	| rec |
	rec := fixedElement encompassingRectangle.
	^ (fixedX value: rec)@ (fixedY value: rec).
]

{ #category : #'public - positioning' }
RSLocate >> right [
	fixedX := #right.
	direction := -1@direction y.
]

{ #category : #'public - executing' }
RSLocate >> stick: movableElement on: fixedElement [
	| block |
	block := [ self move: movableElement on: fixedElement ].
	block value.
	fixedElement 
		when: TSExtentChangedEvent do: block;
		when: TSPositionChangedEvent do: block.
]

{ #category : #'public - positioning' }
RSLocate >> top [
	fixedY := #top.
	direction := direction x @ 1
]
