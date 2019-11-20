"
This interaction layouts the connected subgraphs of a view using a rectangle pack layout each time the view changes it's extent (e.g. a window resize).
"
Class {
	#name : #RSHierarchyPacker,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'rectanglePackLayout'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #private }
RSHierarchyPacker >> fill: group with: aShape [
	group add: aShape.
	aShape outgoingEdges do: [ :ed | 
		self fill: group with: ed to ].
]

{ #category : #private }
RSHierarchyPacker >> initialize [
	super initialize.
	
	rectanglePackLayout := RSRectanglePackLayout new
		doNotUseProgressBar;
		yourself.
]

{ #category : #private }
RSHierarchyPacker >> onShape: aCanvas [
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
		aCanvas zoomToFit; signalUpdate ].

]

{ #category : #accessing }
RSHierarchyPacker >> rectanglePackLayout [
	^ rectanglePackLayout
]

{ #category : #accessing }
RSHierarchyPacker >> rectanglePackLayout: anObject [
	rectanglePackLayout := anObject
]
