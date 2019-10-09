Class {
	#name : #RSForceBasedLayoutTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'classes'
	],
	#category : #'Roassal3-Global-Tests-Layouts'
}

{ #category : #running }
RSForceBasedLayoutTest >> setUp [
	view := RSView new.
	classes := RSShapeBuilder box
		size: 10;
		elementsOn: Collection withAllSubclasses.
	RSEdgeBuilder line
		view: view;
		elements: classes;
		color: (Color blue alpha: 0.5);
		connectFrom: #superclass to: #yourself.
	view addAll: classes.
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAddNodesAndEdges [

	TSForceBasedLayout new
		start;
		addNodes: classes;
		addEdges: view edges;
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
