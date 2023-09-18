"
This class combines a cluster tree layout and Radial tree layout to undestand big groups
"
Class {
	#name : #RSClusterRadialTreeLayout,
	#superclass : #RSClusterTreeLayout,
	#category : #'Roassal-Layouts-Tree'
}

{ #category : #examples }
RSClusterRadialTreeLayout class >> exampleWithNumber [
	| canvas shapes color |
	canvas := RSCanvas new.

	color := RSColorPalette sequential bupu3.
	shapes := (1 to: 100) collect: [ :m |
		RSBox new
			size: 7;
			model: m;
			draggable;
			withBorder;
			color: (color scale: m);
			yourself.
		 ].
	RSLineBuilder line
		shapes: shapes;
		canvas: canvas;
		connectFrom: [ :n | n // 2 ].
	canvas edges do: #withBorder.
	canvas addAll: shapes.
	canvas shapes @ RSHighlightable red.
	self on: shapes.
	canvas zoomToFit.
	^ canvas open
]

{ #category : #'drawing - general' }
RSClusterRadialTreeLayout >> draw: aNode [
	self draw: aNode level: 1.
]

{ #category : #'drawing - general' }
RSClusterRadialTreeLayout >> draw: aNode level: level [
	| layer allChildren position |
	layer := self layerOf: aNode.
	
	position := (Point r: (maxLayer - layer) * verticalGap theta: (maxAbcissa - (self xOf: aNode) / maxAbcissa) * 2 * Float pi).
	level > 3 ifTrue: [ 
		allChildren := self allChildrenFor: aNode.
		allChildren add: aNode.
		allChildren do: [ :each | each properties: nil ].
		RSClusterTreeLayout new
			horizontalGap: horizontalGap * 0.3;
			verticalGap: verticalGap * 0.3;
			on: allChildren.
		allChildren do: [ :each | each translateBy: position ].
		^ self
		 ].
	
	(self childrenFor: aNode) do: [ :e | self draw: e level: level + 1 ].
	translator
		translateTopLeftOf: aNode
		to: position
]
