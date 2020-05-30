[list of classes](reference.md)
# RSLocation
`RSLocation` locates shapes with respect to other shapes. Shapes can be positioned in a sticky fashion or not. Being sticky means whether the base shapes "drag" the sitcky shapes when dragged. `RSLocation` iteratively builds constraint for moving and positioning a shape on top of another one.

*Responsibility*: locate permanently or not some shapes with respect to other shapes.

*Collaborators*: closely interact with `RSShape`, `RSExtentChangedEvent`, and `RSPositionChangedEvent`

*Variables*:
- `offset`: offset between the positioned shape and the base shape
- `orientation`: a value that could be -1, 0, 1 indicating the orientation of the location
- `direction`: a point indicating the direction of the lcoation

*Example*:
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
"Try changing stick:on: by move:on. Replacing bottom by top"
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