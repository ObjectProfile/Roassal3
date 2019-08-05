"
This interactions adds as
"
Class {
	#name : #RSHierarchyPacker,
	#superclass : #RSAbstractViewInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #private }
RSHierarchyPacker >> fill: group with: e [
	group add: e.
	e outgoingEdges do: [ :ed | 
		self fill: group with: ed to ].
]

{ #category : #private }
RSHierarchyPacker >> onElement: aView [
	| layout connectedAsGroups connected isolated all |
	layout := RSTreeLayout new
		edges: aView edges.
	connectedAsGroups := aView elements.
	connected := connectedAsGroups select: #hasEdges.
	isolated := connectedAsGroups reject: #hasEdges.

	connectedAsGroups := (layout rootNodesFor: connected) collect: [ :e | 
		| group |
		group :=  TSGroup new.
		self fill: group with: e.
		group ]. 
	
	all := connectedAsGroups, isolated.

	aView when: TSExtentChangedEvent do: [ 
		RSRectanglePackLayout new
			doNotUseProgressBar;
			preferredAngle: aView extent angle;
			on: all.
		aView zoomToFit; signalUpdate ].

]
