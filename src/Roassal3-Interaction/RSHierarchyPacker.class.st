"
This interaction layouts the connected subgraphs of a view using a rectangle pack layout each time the view changes it's extent (e.g. a window resize).
"
Class {
	#name : #RSHierarchyPacker,
	#superclass : #TSAbstractCanvasInteraction,
	#instVars : [
		'rectanglePackLayout'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #private }
RSHierarchyPacker >> fill: group with: e [
	group add: e.
	e outgoingEdges do: [ :ed | 
		self fill: group with: ed to ].
]

{ #category : #private }
RSHierarchyPacker >> initialize [
	super initialize.
	
	rectanglePackLayout := TSRectanglePackLayout new
		doNotUseProgressBar;
		yourself.
]

{ #category : #private }
RSHierarchyPacker >> onElement: aView [
	| layout connectedAsGroups connected isolated all |
	layout := TSTreeLayout new
		edges: aView edges.
	connectedAsGroups := aView elements.
	connected := connectedAsGroups select: #hasEdges.
	isolated := connectedAsGroups reject: #hasEdges.

	connectedAsGroups := (layout rootNodesFor: connected) collect: [ :e | 
		| group |
		group :=  RSGroup new.
		self fill: group with: e.
		group ]. 
	
	all := connectedAsGroups, isolated.

	aView when: RSExtentChangedEvent do: [
		rectanglePackLayout
			preferredAngle: aView extent angle;
			on: all.
		aView zoomToFit; signalUpdate ].

]

{ #category : #accessing }
RSHierarchyPacker >> rectanglePackLayout [
	^ rectanglePackLayout
]

{ #category : #accessing }
RSHierarchyPacker >> rectanglePackLayout: anObject [
	rectanglePackLayout := anObject
]
