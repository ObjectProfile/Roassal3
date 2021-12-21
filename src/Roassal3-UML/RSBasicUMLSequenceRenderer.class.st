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

	| descriptor startCircle selectorLabel durationLabel goingLine endCircle |
	descriptor := self modelDescriptor.

	startCircle := descriptor startCircleOf: timedMessageSend.
	endCircle := descriptor endCircleOf: timedMessageSend.

	selectorLabel := descriptor selectorLabelOf: timedMessageSend.
	durationLabel := descriptor durationLabelOf: timedMessageSend.

	goingLine := lineBuilder
		             edgeFrom: (startCircle propertyAt: #startCircle)
		             to: endCircle.

	timedMessageSend messageSend styleLine: goingLine.

	RSLocation new
		above;
		stick: selectorLabel on: goingLine.

	RSLocation new
		below;
		stick: durationLabel on: selectorLabel.

	^ (RSGroup withAll: { 
			   startCircle.
			   selectorLabel.
			   durationLabel.
			   endCircle.
			   goingLine }) asShape
]
