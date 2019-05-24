Class {
	#name : #RSInspectableExample,
	#superclass : #RSObject,
	#category : #'Roassal3-Inspector'
}

{ #category : #'as yet unclassified' }
RSInspectableExample >> simpleExample [
	<script: 'self new simpleExample'>
	| classes v shape elements inspectable highligtable |
	classes := Collection withAllSubclasses.
	v := RSView new.
	shape := RSShapeBuilder box
		popup;
		width: [ :cls | cls instVarNames size * 5 max: 5 ];
		height: [ :cls | cls numberOfMethods max: 5 ].
	elements := shape elementsOn: classes.
	v addAll: elements.
	RSEdgeBuilder line
		view: v;
		objects: classes;
		withVerticalAttachPoint;
		connectFrom: #superclass.
	RSTreeLayout on: elements.
	RSInspectable reset.
	inspectable := RSInspectable new.
	highligtable := inspectable highlightable.
	highligtable highlightShape color: Color green.
	inspectable
		inspectElementBlock: [ :cls | 
			| builder |
			builder := RSUMLClassBuilder new.
			builder classes: {cls}.
			builder build.
			builder open ].
	"inspectable inspectElementBlock: [ :cls | GTInspector openOn: cls ]."
	elements @ inspectable.
	v @ RSControlsView.
	v open
]
