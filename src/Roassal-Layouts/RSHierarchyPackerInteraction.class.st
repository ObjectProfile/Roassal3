"
This interaction layouts the connected subgraphs of a view using a rectangle pack layout each time the view changes it's extent (e.g. a window resize).

Adapt the layout based on the window size:
-=-=-=-=-=-=-=-=-=
numberOfBoxes := 50.
r := Random seed: 42.
shapes := RSGroup new.
numberOfBoxes timesRepeat: [ 
    shapes add: (RSBox new width: (r nextInt: 40); height: (r nextInt: 40)) ].

c := RSCanvas new. 
c addAll: shapes.
RSRectanglePackLayout new useProgressBar; on: shapes.
c @ RSCanvasController @ RSHierarchyPacker.
c open
-=-=-=-=-=-=-=-=-=

Another example:
-=-=-=-=-=-=-=-=-=
""Try resizing the window. Note that it also works in the inspector""
classes := { 'Roassal-Layouts'. 'Roassal' }
	flatCollect: [:pkgname | (RPackage organizer
		packageNamed: pkgname) definedClasses ].
shapes := RSGroup new.
classes do: [ :c | shapes add: (RSEllipse new model: c) ].

c := RSCanvas new.
c addAll: shapes.

eb := RSEdgeBuilder orthoVertical.
eb canvas: c.
eb connectFrom: #superclass.

RSNormalizer size
	shapes: shapes;
	normalize: [ :c | c numberOfMethods + 5 ].
RSTreeLayout on: shapes.
c @ RSCanvasController @ RSHierarchyPacker.
c open
-=-=-=-=-=-=-=-=-=

Another example:
-=-=-=-=-=-=-=-=-=
builder := RSUMLClassBuilder new.
classes := { 'Roassal-Layouts'. 'Roassal' }
	flatCollect: [:pkgname | (RPackage organizer
		packageNamed: pkgname) definedClasses ].
builder classes: classes.
builder renderer: RSTorchUMLClassRenderer new.
builder build.
builder canvas @ RSHierarchyPacker.
builder canvas open
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSHierarchyPackerInteraction,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'rectanglePackLayout'
	],
	#category : #'Roassal-Layouts-Interactions'
}

{ #category : #private }
RSHierarchyPackerInteraction >> fill: group with: aShape [
	group add: aShape.
	aShape outgoingLines do: [ :ed |
		self fill: group with: ed to ]
]

{ #category : #initialization }
RSHierarchyPackerInteraction >> initialize [
	super initialize.

	rectanglePackLayout := RSRectanglePackLayout new
		doNotUseProgressBar;
		yourself
]

{ #category : #private }
RSHierarchyPackerInteraction >> onShape: aCanvas [
	| layout connectedAsGroups connected isolated all |
	layout := RSTreeLayout new
		edges: aCanvas edges.
	connectedAsGroups := aCanvas nodes.
	connected := connectedAsGroups select: #hasEdges.
	isolated := connectedAsGroups reject: #hasEdges.

	connectedAsGroups := (layout rootNodesFor: connected) collect: [ :e |
		| group |
		group :=  RSGroup new.
		self fill: group with: e.
		group ].

	all := connectedAsGroups, isolated.

	aCanvas when: RSExtentChangedEvent do: [
		rectanglePackLayout
			preferredAngle: aCanvas extent angle;
			on: all.
		aCanvas zoomToFit; signalUpdate ]
	for: self
]

{ #category : #accessing }
RSHierarchyPackerInteraction >> rectanglePackLayout [
	^ rectanglePackLayout
]

{ #category : #accessing }
RSHierarchyPackerInteraction >> rectanglePackLayout: anObject [
	rectanglePackLayout := anObject
]
