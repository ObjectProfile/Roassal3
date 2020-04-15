Class {
	#name : #RSAbstractLabelDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title',
		'rotationAngle',
		'offset',
		'fontSize'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractLabelDecoration >> createLabel [
	"Utility method to create a label"
	^ RSLabel new
		text: title;
		fontSize: fontSize;
		color: Color black;
		rotateByDegrees: rotationAngle
]

{ #category : #accessing }
RSAbstractLabelDecoration >> fontSize [
	"Return the font size to use when generating labels"
	^ fontSize
]

{ #category : #accessing }
RSAbstractLabelDecoration >> fontSize: fontSizeToUse [
	"Set the font size to use when generating labels"
	fontSize := fontSizeToUse
]

{ #category : #initialization }
RSAbstractLabelDecoration >> initialize [
	super initialize.
	rotationAngle := 0.
	fontSize := 10
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

{ #category : #accessing }
RSAbstractLabelDecoration >> vertical [
	"Set the label vertical"
	self rotationAngle: -90
]
