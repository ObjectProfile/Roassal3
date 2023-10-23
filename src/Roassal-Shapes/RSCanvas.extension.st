Extension { #name : 'RSCanvas' }

{ #category : '*Roassal-Shapes' }
RSCanvas >> asShape [
	"Convert a canvas as a composite shape. Note that all the shapes are removed from the canvas after the convertion. Here is an example:

```
canvas := RSCanvas new.
5 timesRepeat: [
	tmpCanvas := RSCanvas new.
	someShapes := RSCircle models: (1 to: 50) forEach: [ :s :e | s size: 10 ].
	tmpCanvas addAll: someShapes.
	RSGridLayout on: tmpCanvas shapes.
	tmpCanvas shapes color: Color random translucent.
	canvas add: tmpCanvas asShape.
].

RSGridLayout on: canvas shapes.
canvas @ RSCanvasController
```

Another example:
```
g1 := RSChart new.
p1 := RSLinePlot new.
p1 y: #(5 10 3 -4 -5 15).
g1 addPlot: p1.
g1 addDecoration: (RSXLabelDecoration new title: 'Time'; offset: 0 @ 10).
g1 addDecoration: (RSYLabelDecoration new title: 'Value'; offset: -20 @ 0).
g1 addDecoration: (RSHorizontalTick new).
g1 addDecoration: (RSVerticalTick new).
g1 build.

g2 := RSChart new.
p2 := RSLinePlot new.
p2 y: #(2 10 50 -20 40 30 25 12 4).
g2 addPlot: p2.
g2 addDecoration: (RSXLabelDecoration new title: 'Time'; offset: 0 @ 10).
g2 addDecoration: (RSYLabelDecoration new title: 'Value'; offset: -20 @ 0).
g2 addDecoration: (RSHorizontalTick new).
g2 addDecoration: (RSVerticalTick new).
g2 build.

c := RSCanvas new.
c add: (g1 canvas asShape).
c add: (g2 canvas asShape).
RSHorizontalLineLayout on: c shapes.
c @ RSCanvasController.
c
```
	"
	| g |
	g := self shapes copy.
	g do: #remove.
	^ RSComposite new
		shapes: g;
		yourself
]

{ #category : '*Roassal-Shapes' }
RSCanvas >> asShapeModel: aModelObject [
	"Convert a canvas as a composite shape. Note that all the shapes are removed from the canvas after the convertion. Attach a model to the composite shape. Here is an example:

Another example:
```
g1 := RSChart new.
p1 := RSLinePlot new.
p1 y: #(5 10 3 -4 -5 15).
g1 addPlot: p1.
g1 addDecoration: (RSXLabelDecoration new title: 'Time'; offset: 0 @ 10).
g1 addDecoration: (RSYLabelDecoration new title: 'Value'; offset: -20 @ 0).
g1 addDecoration: (RSHorizontalTick new).
g1 addDecoration: (RSVerticalTick new).
g1 build.

g2 := RSChart new.
p2 := RSLinePlot new.
p2 y: #(2 10 50 -20 40 30 25 12 4).
g2 addPlot: p2.
g2 addDecoration: (RSXLabelDecoration new title: 'Time'; offset: 0 @ 10).
g2 addDecoration: (RSYLabelDecoration new title: 'Value'; offset: -20 @ 0).
g2 addDecoration: (RSHorizontalTick new).
g2 addDecoration: (RSVerticalTick new).
g2 build.

c := RSCanvas new.
c add: (g1 canvas asShapeModel: 1).
c add: (g2 canvas asShapeModel: 2).
RSHorizontalLineLayout on: c shapes.

c shapes @ RSDraggable.

lb := RSLineBuilder arrowedLine.
lb withBorderAttachPoint.
lb canvas: c.
lb useAssociation: 1 -> 2.

c @ RSCanvasController.
c
```
	"
	^ self asShape model: aModelObject
]
