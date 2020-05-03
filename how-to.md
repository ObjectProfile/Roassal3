# How-to guides

This page provides a list of recipes to solve a particular problem you have. This list will expand from the questions the Roassal community receive. If you wish to have a new how-to, just ask your question in the #Roassal channel on the [Pharo discord server](https://pharo.org/community).

## How to visualize any arbitrary object

You have a class `C` and you wish to create a visualization that appears when you inspect an object instance of `C`. You need to define two methods:

```Smalltalk
C>>gtInspectorViewIn: composite
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'View';
		initializeCanvas: [ self visualize ]
```

and 

```Smalltalk
C>>visualize
	| canvas |
	canvas := RSCanvas new.
	"build your visualization here"
	^ canvas
```

Note that the method `visualize` should return a Roassal canvas. The method `gtInspectorViewIn:` has an arbitrary name. You can choose any name, but it must receive an argument, which we typically name `composite`.

## How to create a chart from a list of numbers

Assuming you have a set of values:

```Smalltalk
values := #(40 23 12 15 63).
```

You can visualize the value contained in `values` using:

```
c := RSChart new.
c addPlot: (RSLinePlot new y: values).
c addDecoration: (RSVerticalTick new).
c addDecoration: (RSHorizontalTick new).
c
```

A chart appears when you evaluate the script.

## How can I use animation to execute a block at a regular pace

Consider the following code:

```Smalltalk
canvas := RSCanvas new.
counter := 0.
canvas add: (label := RSLabel new text: counter).
canvas newAnimation repeat
    duration: 1.5 seconds;
    when: RSAnimationLoopEvent do: [ :evt|
        label text: (counter := counter + 1) ].
canvas
```

The block provided to the message `when:do:` can contains any arbitrary code. The example shows that the visualization can be changed from the block.


## How can I draw a SVG path

Roassal offers the class `RSSVGPath`, which is a shape. You can use it as:

```Smalltalk
svgPath := 'M150 0 L75 200 L225 200 Z'.
c := RSCanvas new.
svg := RSSVGPath new color: Color blue; svgPath: svgPath.
c add: svg.
c @ RSCanvasController.
c
```


