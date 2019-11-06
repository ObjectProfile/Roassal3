Class {
	#name : #RSForceBasedLayoutTest,
	#superclass : #TSTest,
	#instVars : [
		'classes',
		'canvas'
	],
	#category : #'Roassal3-Global-Tests-Layouts'
}

{ #category : #running }
RSForceBasedLayoutTest >> setUp [
	canvas := TSCanvas new.
	classes := Collection withAllSubclasses collect:[:cls |
		TSBox new model: cls; size: 10; yourself].
	TSEdgeBuilder line
		canvas: canvas;
		shapes: classes;
		color: (Color blue alpha: 0.5);
		connectFrom: #superclass to: #yourself.
	canvas addAll: classes.
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAddNodesAndEdges [

	TSForceBasedLayout new
		start;
		addNodes: classes;
		addEdges: canvas edges;
		step.
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAttributes [
	TSForceBasedLayout new
		length: 100;
		charge: -300;
		center: 200@200;
		on: classes
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testBasic [
	TSForceBasedLayout on: classes.
	TSForceBasedLayout new
		doNotUseProgressBar;
		on: classes.
]
