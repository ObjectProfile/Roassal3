"
RSCircleLayout is a layout algorithm that arranges shapes in a circle around a center point. The objects are placed evenly around the circle, with a specified distance from the center.

To use RSCircleLayout, create an instance of the class and specify the center point and radius of the circle using the center and radius instance variables. Then, use `on:` method with the shapes you want to layout.

RSCircleLayout supports customizable attributes such as angle offsets, and radial offsets. These attributes can be set using the corresponding instance variables.

For more information, see the class methods and instance variables of RSCircleLayout.
"
Class {
	#name : #RSCircleLayout,
	#superclass : #RSAbstractCircleLayout,
	#category : #'Roassal-Layouts-Circle'
}

{ #category : #examples }
RSCircleLayout class >> example1 [
	| aLayout objects |
	aLayout := self new.
	aLayout center: 200@200.
	aLayout radius: 100.
	objects := RSBox models: (1 to: 10).
	aLayout on: objects.
	^ RSCanvas new
		addAll: objects;
		@ RSCanvasController;
		open
]

{ #category : #examples }
RSCircleLayout class >> example2 [
	| nodes canvas shapes |
	nodes := (1 to: 5).

	canvas := RSCanvas new.
	shapes := RSCircle models: nodes.
	shapes size: 30.
	canvas addAll: shapes.

	self new radius: 20; on: shapes.
	canvas @ RSCanvasController.
	^ canvas open
]

{ #category : #'instance creation' }
RSCircleLayout class >> scaleBy: aNumber [

	^self new scaleBy: aNumber
]

{ #category : #hook }
RSCircleLayout >> doExecute: shapes [
	| angle rad angleInc center |
	rad := self computeRadiusFor: shapes.
	angleInc := self computeIncrementalAngleFor: shapes.
	angle := self initialAngle.
	center := self computeCenter: rad.
	
	shapes do: [ :shape |
		| point |
		point := center + (Point r: rad theta: angle).
		angle := angle + angleInc.
		translator translateTopLeftOf: shape to: point.
	]
]
