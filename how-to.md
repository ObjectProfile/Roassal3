# How-to guides

This page provides a list of recipes 

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


