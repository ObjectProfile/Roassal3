"
I use the RSShapeBuilder
"
Class {
	#name : #RoassalShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #shapes }
RoassalShapeExamples >> example01Basic [
	<script: 'self new example01Basic'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red ]
			ifFalse: [ Color blue ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	v open
]

{ #category : #shapes }
RoassalShapeExamples >> example02Basic [
	<script: 'self new example02Basic'>

	| v box box1 box2 line |
	v := RSView new.
	box := RSShapeBuilder box
		size: 100";
		interactionDo: [ :i | i draggable ]".
	box interaction draggable.
	box1 := box element.
	box1 translateBy: 150@150.
	box2 := box element.
	v add: box1.
	"line := RSEdgeBuilder line 
		color: Color red;
		attachPoint: RSCenteredAttachPoint new.
	v add: (line edgeFrom: box1 to: box2)."
	
	v add: ((RSEdge from: box1 to: 0@0) 
		trachelShape: (TSLine new color: Color red)).
	v open
	



]
