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

	lineBuilder := RSLineBuilder arrowedLine
		               attachPoint: RSCenteredAttachPoint new;
		               yourself
]

{ #category : #hooks }
RSBasicUMLSequenceRenderer >> shapeFor: timedMessageSend [

	| descriptor startCircle shapes selectorLabel durationLabel goingLine endCircle |
	descriptor := self modelDescriptor.

	startCircle := descriptor startCircleOf: timedMessageSend.
	endCircle := descriptor endCircleOf: timedMessageSend.

	selectorLabel := descriptor selectorLabelOf: timedMessageSend.
	durationLabel := descriptor durationLabelOf: timedMessageSend.

	RSLocation new
		outer;
		bottom;
		stick: durationLabel on: selectorLabel.

	shapes := OrderedCollection new
		          add: startCircle;
		          add: selectorLabel;
		          add: durationLabel;
		          yourself.

	goingLine := lineBuilder edgeFrom: startCircle to: endCircle.

	timedMessageSend messageSend styleLine: goingLine.

	RSLocation new above
		top;
		offset: startCircle width / 2 @ 0;
		stick: selectorLabel on: goingLine.

	shapes
		add: endCircle;
		add: goingLine.

	^ RSComposite new
		  model: timedMessageSend;
		  shapes: shapes;
		  yourself
]
