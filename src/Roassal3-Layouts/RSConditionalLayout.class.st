"
<keyClass>
`RSConditionalLayout` applies two layouts on a set of shapes using a condition

*Responsibility*: Shapes matching a given condition use a particular layout, else another layout is applied 

*Collaborators*: Shapes and layouts

*Variables*:
- `if`: one-arg block or symbol to be applied on a shape. Must return a boolean when applied. 
- `thenLayout`: a layout used for the shapes that matches the condition
- `thenLayout `: a layout used for the shapes that do not match the condition

*Example*:
```Smalltalk
classes := Collection allSubclasses.
shapes := classes collect: [ :c | RSBox new size: 10; model: c ] as: RSGroup.

c := RSCanvas new.
c addAll: shapes.
eb := RSEdgeBuilder orthoVertical.
eb canvas: c.
eb withVerticalAttachPoint.
eb shapes: shapes.
eb connectFrom: #superclass.

""RSTreeLayout on: shapes.""
RSConditionalLayout new
	ifNotConnectedThen: RSGridLayout new;
	else: RSTreeLayout new;
	on: shapes.
c @ RSCanvasController
```

Another example:

```Smalltalk
classes := Collection allSubclasses.
shapes := classes collect: [ :c | RSBox new size: 10; model: c ] as: RSGroup.

c := RSCanvas new.
c addAll: shapes.
eb := RSEdgeBuilder orthoVertical.
eb canvas: c.
eb withVerticalAttachPoint.
eb shapes: shapes.
eb connectFrom: #superclass.

""RSTreeLayout on: shapes.""
RSConditionalLayout new
	ifConnectedThen: RSTreeLayout new;
	else: RSGridLayout new;
	on: shapes.
c @ RSCanvasController
```
"
Class {
	#name : #RSConditionalLayout,
	#superclass : #RSLayout,
	#instVars : [
		'if',
		'thenLayout',
		'elseLayout'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSConditionalLayout >> doExecute: shapes [
	"Performs the layout"

	| thenShapes elseShapes |
	thenShapes := (shapes select: if) asGroup.
	elseShapes := (shapes reject: if) asGroup.
	thenLayout on: thenShapes.
	elseLayout on: elseShapes.

	RSLocation new
		left;
		outer;
		offset: -20 @ 0;
		move: thenShapes on: elseShapes.

]

{ #category : #accessing }
RSConditionalLayout >> else: aLayout [
	elseLayout := aLayout
]

{ #category : #accessing }
RSConditionalLayout >> if [
	^ if
]

{ #category : #accessing }
RSConditionalLayout >> if: aOneArgBlockOrSymbol [
	"Take as argument a block that will be used on the shapes. The block should return a boolean"
	if := aOneArgBlockOrSymbol
]

{ #category : #accessing }
RSConditionalLayout >> ifConnectedThen: aLayout [
	self if: [ :shape | shape hasEdges ].
	self then: aLayout
]

{ #category : #accessing }
RSConditionalLayout >> ifNotConnectedThen: aLayout [
	self if: [ :shape | shape hasEdges not ].
	self then: aLayout
]

{ #category : #accessing }
RSConditionalLayout >> then: aLayout [
	thenLayout := aLayout
]
