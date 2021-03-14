"
TODO
"
Class {
	#name : #RSAbstractLabelDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title',
		'baseShape',
		'location',
		'label'
	],
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #accessing }
RSAbstractLabelDecoration >> baseShape [
	^ baseShape
]

{ #category : #accessing }
RSAbstractLabelDecoration >> baseShape: aRSLabel [
	baseShape := aRSLabel
]

{ #category : #rendering }
RSAbstractLabelDecoration >> createLabel [
	"Utility method to create a label"
	^ baseShape copy
		text: title;
		yourself
		
]

{ #category : #accessing }
RSAbstractLabelDecoration >> fontSize [
	"Return the font size to use when generating labels"
	^ baseShape fontSize
]

{ #category : #accessing }
RSAbstractLabelDecoration >> fontSize: fontSizeToUse [
	"Set the font size to use when generating labels"
	baseShape fontSize: fontSizeToUse
]

{ #category : #accessing }
RSAbstractLabelDecoration >> horizontal [
	"Set the label horizontal"
	self rotationAngle: 0
]

{ #category : #initialization }
RSAbstractLabelDecoration >> initialize [
	super initialize.
	baseShape := RSLabel new.
	location := RSLocation new.
]

{ #category : #accessing }
RSAbstractLabelDecoration >> label [
	^ label
]

{ #category : #accessing }
RSAbstractLabelDecoration >> location [
	^ location
]

{ #category : #accessing }
RSAbstractLabelDecoration >> location: aRSLocation [
	^ location
]

{ #category : #accessing }
RSAbstractLabelDecoration >> offset [
	^ location offset
]

{ #category : #accessing }
RSAbstractLabelDecoration >> offset: aPointOrNumber [
	"Set the translation distance to set the label"
	location offset: aPointOrNumber
]

{ #category : #rendering }
RSAbstractLabelDecoration >> renderIn: canvas [
	label := self createLabel.
	location move: label on: canvas encompassingRectangle.
	canvas add: label
]

{ #category : #accessing }
RSAbstractLabelDecoration >> rotationAngle: anAngleAsFloat [
	"Set the rotation the label should have"
	^ baseShape rotateByDegrees: anAngleAsFloat
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
