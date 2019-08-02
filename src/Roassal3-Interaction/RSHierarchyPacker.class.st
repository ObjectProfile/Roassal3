Class {
	#name : #RSHierarchyPacker,
	#superclass : #Object,
	#category : #'Roassal3-Interaction'
}

{ #category : #'as yet unclassified' }
RSHierarchyPacker >> applyto: view [
	| foo connectedAsGroups connected isolated all |
	foo := RSTreeLayout new
		edges: view edges.
	connectedAsGroups := view elements.
	connected := connectedAsGroups select: #hasEdges.
	isolated := connectedAsGroups reject: #hasEdges.

	connectedAsGroups := (foo rootNodesFor: connected) collect: [ :e | 
		| group |
		group :=  TSGroup new.
		self fill: group with: e.
		group ]. 
	
	all := connectedAsGroups, isolated.

	view when: TSExtentChangedEvent do: [ 
		RSRectanglePackLayout new
			preferredAngle: view extent angle;
			on: all.
		view zoomToFit; signalUpdate ].

]

{ #category : #'as yet unclassified' }
RSHierarchyPacker >> fill: group with: e [
	group add: e.
	e outgoingEdges do: [ :ed | 
		self fill: group with: ed to ].
]
