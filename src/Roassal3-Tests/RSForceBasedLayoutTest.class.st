Class {
	#name : #RSForceBasedLayoutTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'classes'
	],
	#category : #'Roassal3-Tests-Layouts'
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

	RSForceBasedLayout2 new
		length: 100;
		charge: -300;
		center: 200@200;
		on: classes
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testAttributes [
	RSForceBasedLayout2 new
		length: 100;
		charge: -300;
		center: 200@200;
		on: classes
		
]

{ #category : #tests }
RSForceBasedLayoutTest >> testBasic [
	RSForceBasedLayout2 on: classes.
	RSForceBasedLayout2 new
		doNotUseProgressBar;
		on: classes.
]
