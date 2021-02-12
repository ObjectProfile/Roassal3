"
I am a simple interaction that allows to shapes keep size ratio or with in the case of the border

Here is an example:
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
	#name : #RSKeepBorderWidthRatio,
	#superclass : #RSAbstractScaleInteraction,
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #hooks }
RSKeepBorderWidthRatio >> onShape: aShape [
	| width |
	aShape isInACanvas ifFalse: [ self error: 'aShape needs to be part of one canvas' ].
	width := aShape border width.
	aShape canvas when: RSScaleChangedEvent do: [:evt | 
		aShape border width: (self scaleFor: evt) * width.
		evt signalUpdate ]. 
]
