"
My instances can have more than 2 control points.
My Subclasses are: `RSBezier`, `RSPolyline`.

Use `controlPointsController:` to calculate the control points for these lines.
Check this class `RSAbstractCPController` to get more information about it.

```
bezier := RSBezier new.
x := RSBox new.
y := RSBox new.
x draggable.
y draggable.
bezier from: x.
bezier to: y.
bezier controlPointsController: (RSBlockCPController new
	block: [:line | 
		{ line from position.
		line from position x @ line to position y.
		 line to position }
		]).
canvas := RSCanvas new.
x position: 100@100.
canvas addAll: { x. y. bezier }.
```
In the previous example we use a RSBlockCPController to compute the bezier control points. But this can be complex, then you will need to create a new class to specify the type of bezier or polyline you want.

```
bezier := RSBezier new.
controller := RSCustomCPController new.
boxes := (1 to: 4) collect: [ :each | RSBox new draggable ].
controller models: boxes.

bezier controlPointsController: controller.
RSGridLayout new gapSize: 100; on: boxes.
canvas := RSCanvas new.
canvas addAll: boxes.
canvas add: bezier.

canvas
```
The previous script allows you to modify the bezier line using movable nodes.

## Markers, and attach points
Similar to the super class these lines supports markers, and attach points.
"
Class {
	#name : 'RSAbstractControlPointsLine',
	#superclass : 'RSAbstractLine',
	#instVars : [
		'controlPoints',
		'controlPointsController'
	],
	#category : 'Roassal-Shapes-Lines',
	#package : 'Roassal-Shapes',
	#tag : 'Lines'
}

{ #category : 'testing' }
RSAbstractControlPointsLine class >> isAbstract [
	^ self =  RSAbstractControlPointsLine
]

{ #category : 'transforming' }
RSAbstractControlPointsLine >> basicTranslateBy: delta [
	controlPoints := controlPoints collect: [:p | p + delta ]
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> controlPoints [
	^ controlPoints ifNil: [ controlPoints := { 0@0. 0@0 } ]
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> controlPoints: anArrayOfPoints [
	controlPoints := anArrayOfPoints collect: #asFloatPoint.
	self resetPath
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> controlPointsController [
	^ controlPointsController
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> controlPointsController: aCPController [
	controlPointsController := aCPController
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> endPoint [
	^ self controlPoints last
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> endPoint: aPoint [
	self controlPoints
		at: self controlPoints size
		put: aPoint.
	self resetPath
]

{ #category : 'testing' }
RSAbstractControlPointsLine >> isControlPointsLine [
	^ true
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> position: aPoint [
	| position delta |
	position := self position.
	delta := aPoint - position.
	self controlPoints: controlPoints + delta
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> startPoint [
	^ self controlPoints first
]

{ #category : 'accessing' }
RSAbstractControlPointsLine >> startPoint: aPoint [
	self controlPoints at: 1 put: aPoint.
	self resetPath
]

{ #category : 'update' }
RSAbstractControlPointsLine >> update [
	controlPointsController ifNil: [ ^ self ].
	self
		controlPoints: (controlPointsController controlPointsFor: self);
		notifyExtentChanged
]
