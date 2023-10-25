"
I am an interaction for edges becacuse I access to markers from edges.

I change the size of the marker allow it to remain in the same size

Example:
| v sb label box |
	v := RSView new.
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		border: TSBorder new;
		cornerRadius: (TSCornerRadius new right: 10);
		extent: [ :lb | lb extent + 5 ].
	sb := RSShapeBuilder composite
		interactionDo: #draggable;
		shapes: [ :m | | l |
			l := label elementOn: m.
			TSGroup with: (box elementOn: l) with: l].
	v addAll: (sb elementsOn: ArrayedCollection withAllSubclasses).
	v @ RSControlsView.
	RSEdgeBuilder orthoHorizontal
		markerEnd: (TSMarker new 
			offsetRatio: 0.1;
			shape: (RSShapeBuilder triangle 
				color: Color red;
				size: 10;
				element));
		attachPoint: RSHorizontalAttachPoint new; 
		border: (TSBorder new);
		view: v;
		elements: v elements;
		connectFrom: #superclass.
	""v edges @ RSKeepBorderWidthRatio. Not necessary since all edges shares the same border""
	
	v edges first @ RSKeepBorderWidthRatio. 
	v edges first @ RSKeepMarkersSizeRatio.
	RSHorizontalTreeLayout new on: v elements.
	v open setLabel: 'Horizontal Tree'
	
"
Class {
	#name : 'RSKeepMarkersSizeRatioInteraction',
	#superclass : 'RSAbstractScaleInteraction',
	#category : 'Roassal-Interaction-Extra',
	#package : 'Roassal-Interaction',
	#tag : 'Extra'
}

{ #category : 'hooks' }
RSKeepMarkersSizeRatioInteraction >> onShape: anEdge [
	| markers sizes offsets |
	anEdge isInACanvas ifFalse: [ self error: 'add this edge to a canvas first' ].
	markers := anEdge markers select: #notNil.
	sizes := markers collect: [:marker | marker shape extent].
	offsets := markers collect: #offset.
	anEdge canvas when: RSScaleChangedEvent do: [ :evt | | delta |
		delta := self scaleFor: evt.
		markers doWithIndex: [ :marker :index |
			marker shape extent: delta * (sizes at: index).
			marker offset: delta * (offsets at: index)  ] ]
	for: self
]
