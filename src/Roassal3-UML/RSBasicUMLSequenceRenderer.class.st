"
A basic renderer for UML sequences.
"
Class {
	#name : #RSBasicUMLSequenceRenderer,
	#superclass : #RSAbstractUMLSequenceRenderer,
	#instVars : [
		'lineBuilder'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #initialization }
RSBasicUMLSequenceRenderer >> initialize [

	super initialize.

	lineBuilder := RSLineBuilder arrowedLine yourself
]

{ #category : #hooks }
RSBasicUMLSequenceRenderer >> shapeFor: anAssociation [

	| descriptor startCircle shapes selectorLabel durationLabel edge goingLine endCircle |
	descriptor := self modelDescriptor.

	startCircle := descriptor startCircleOf: anAssociation.
	endCircle := descriptor endCircleOf: anAssociation.

	selectorLabel := descriptor selectorLabelOf: anAssociation.
	durationLabel := descriptor durationLabelOf: anAssociation.

	RSLocation new
		outer;
		bottom;
		stick: durationLabel on: selectorLabel.

	shapes := OrderedCollection new
		          add: startCircle;
		          add: selectorLabel;
		          add: durationLabel;
		          yourself.

	edge := anAssociation value
		        ifSelfSend: [ endCircle -> startCircle ]
		        ifNotSelfSend: [ startCircle -> endCircle ].

	goingLine := lineBuilder
		             attachPoint: RSCenteredAttachPoint new;
		             edgeFrom: edge key to: edge value.

	anAssociation value styleLine: goingLine.

	RSLocation new above
		top;
		offset: startCircle width / 2 @ 0;
		stick: selectorLabel on: goingLine.

	shapes
		add: endCircle;
		add: goingLine.


	^ RSComposite new
		  model: anAssociation;
		  shapes: shapes;
		  yourself
]
