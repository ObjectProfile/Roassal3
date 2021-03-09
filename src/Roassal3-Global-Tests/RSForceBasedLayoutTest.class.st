Class {
	#name : #RSForceBasedLayoutTest,
	#superclass : #RSTest,
	#instVars : [
		'classes',
		'canvas'
	],
	#category : #'Roassal3-Global-Tests-Layouts'
}

{ #category : #running }
RSForceBasedLayoutTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	classes := Collection withAllSubclasses collect:[:cls |
		RSBox new model: cls; size: 10; yourself].
	RSLineBuilder line
		canvas: canvas;
		shapes: classes;
		color: (Color blue alpha: 0.5);
		connectFrom: #superclass to: #yourself.
	canvas addAll: classes.
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAddNodesAndEdges [

	RSForceBasedLayout new
		start;
		addNodes: classes;
		addEdges: canvas edges;
		step.
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAttributes [
	RSForceBasedLayout new
		length: 100;
		charge: -300;
		center: 200@200;
		on: classes
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testBasic [
	RSForceBasedLayout on: classes.
	RSForceBasedLayout new
		doNotUseProgressBar;
		on: classes.
]
