"
<keyClass>
`RSHighlightable` is an interaction for shapes to make them highlightable. 

*Responsibility*: make shapes highlightable

*Collaborators*: closely colaborate with `RSShape`

*Variables*:
- `announcer`: highlightable uses announcement to trigger the interaction. 
- `copyKey`: symbol that is used to keep in the property the previous color. One needs to modity the `copyKey` to avoid conflict between several highlightable interactions.
- `highlightShapes`: refers to a one-arg-block that takes as parameter a shape and returns the shapes that must be highlighted. 
- `propertyKey`: symbol that is used in the property of the `RSCanvas` to keep highlighted shapes. This is useful to avoid conflicts between different highlightable.
   

*Example*:
```Smalltalk
c := RSCanvas new.

shapes := (1 to: 10) collect: [ :v | RSEllipse new size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup @ RSDraggable.

RSGridLayout on: shapes.

eb := RSEdgeBuilder arrowedLineWithOffset: 0.5.
eb canvas: c.
eb connectTo: [ :v | 1 ].

int := RSHighlightable new withEdges highlightColor: Color red.
shapes @ int.

c @ RSCanvasController
```

Another example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new border: (RSBorder new color: Color red; width: 3); model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

RSNormalizer size
	shapes: shapes;
	normalize: #yourself.

interaction := RSHighlightable new.
interaction highlightColor: Color blue.
interaction highlightBorder: (RSBorder new color: Color black; width: 3).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```

Another example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSEllipse new  model: v; size: 10 ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

RSEdgeBuilder line
	canvas: c;
	withBorderAttachPoint;
	connectFrom: [ :v | v // 2 ].

interaction := RSHighlightable new.
interaction highlightBorder: (RSBorder new color: Color black; width: 3).
interaction withEdges.
shapes @ interaction.

RSTreeLayout on: shapes.
c @ RSCanvasController
```

```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

interaction := RSHighlightable new.
interaction highlightBorder: (RSBorder new width: 3; color: Color pink).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```

Example of multiple selections:
```Smalltalk
classes := Collection withAllSubclasses.

c := RSCanvas new.
shapes := classes collect: [ :cls | RSBox new model: cls ] as: RSGroup.

c addAll: shapes.
RSNormalizer size shapes: shapes; normalize: #numberOfMethods.
RSFlowLayout on: shapes.

shapes @ RSPopup.


buttonReset := RSLabel text: 'Reset'.
c add: buttonReset.
buttonReset setAsFixed.
buttonReset @ (RSHighlightable defaultRed).
buttonReset when: RSMouseClick do: [ :evt | 
	selectedShapes do: [ :s | highlightable restore: s selector: #color ].
	selectedShapes := RSGroup new.
	lbl text: ''.
	c signalUpdate. ].

buttonInspect := RSLabel text: 'Inspect'.
c add: buttonInspect.
buttonInspect setAsFixed.
buttonInspect @ (RSHighlightable defaultRed).
buttonInspect when: RSMouseClick do: [ :evt | selectedShapes inspect ].

lbl := RSLabel new.
c add: lbl.
lbl setAsFixed.
lbl translateTo: 90 @ 30.

g := {buttonReset . buttonInspect } asGroup.
RSHorizontalLineLayout on: g.
g translateTo: g extent / 2 + (10 @ 10).

selectedShapes := RSGroup new.
highlightable := RSHighlightable new.
shapes when: RSMouseClick do: [ :evt |
	(selectedShapes includes: evt shape) 
		ifFalse: [ selectedShapes add: evt shape ].
	highlightable
			record: evt shape
			selector: #color
			value: Color red.
	lbl text: selectedShapes size asString, ' selected shapes'.
	c signalUpdate.
		 ].

c @ RSCanvasController.
c openOnce
```
"
Class {
	#name : #RSHighlightable,
	#superclass : #RSInteraction,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'copyKey',
		'highlightShapes',
		'propertyKey'
	],
	#category : #'Roassal3-Interaction-Core'
}
