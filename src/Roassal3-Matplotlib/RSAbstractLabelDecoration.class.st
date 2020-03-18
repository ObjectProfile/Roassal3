Class {
	#name : #RSAbstractLabelDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title',
		'rotationAngle',
		'offset'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSAbstractLabelDecoration >> createLabel [
	^ RSLabel new
		text: title;
		fontSize: 10;
		color: Color black;
		rotateByDegrees: rotationAngle
]

{ #category : #initialization }
RSAbstractLabelDecoration >> initialize [
	super initialize.
	rotationAngle := 0
]

{ #category : #accessing }
RSAbstractLabelDecoration >> offset [
	^ offset
]

{ #category : #accessing }
RSAbstractLabelDecoration >> offset: aNumber [
	"Set the translation distance to set the label"
	offset := aNumber
]

{ #category : #accessing }
RSAbstractLabelDecoration >> rotationAngle [
	^ rotationAngle
]

{ #category : #accessing }
RSAbstractLabelDecoration >> rotationAngle: anAngleAsFloat [
	"Set the rotation the label should have"
	rotationAngle := anAngleAsFloat
]

{ #category : #accessing }
RSAbstractLabelDecoration >> title [
	^ title
]

{ #category : #accessing }
RSAbstractLabelDecoration >> title: aLabelAsString [
	"This method is useful to set the name of an axis"
	title := aLabelAsString
]
