"
<keyClass>
`RSAbstractLabelDecoration` is the abstract class for chart labels.

*Responsibility*: manage label decorations for charts.

*Collaborators*: interacts with charts. 

*Variables*:
- location: how the label is located.
- label: the label as an `RSLabel` object.
- title: the title of the label.
"
Class {
	#name : 'RSAbstractLabelDecoration',
	#superclass : 'RSAbstractChartDecoration',
	#instVars : [
		'location',
		'label',
		'title'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'rendering' }
RSAbstractLabelDecoration >> createLabel [
	"Utility method to create a label"
	^ self shape copy
		text: title;
		color: self styler textColor;
		yourself
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> createdShapes [
	^ { label }
]

{ #category : 'initialization' }
RSAbstractLabelDecoration >> defaultShape [
	^ RSLabel new
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> fontSize [
	"Return the font size to use when generating labels"
	^ self shape fontSize
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> fontSize: fontSizeToUse [
	"Set the font size to use when generating labels"
	self shape fontSize: fontSizeToUse
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> horizontal [
	"Set the label horizontal"
	self rotationAngle: 0
]

{ #category : 'initialization' }
RSAbstractLabelDecoration >> initialize [
	super initialize.
	location := RSLocation new
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> label [
	^ label
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> location [
	^ location
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> location: aRSLocation [
	^ location
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> offset [
	^ location offset
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> offset: aPointOrNumber [
	"Set the translation distance to set the label"
	location offset: aPointOrNumber
]

{ #category : 'rendering' }
RSAbstractLabelDecoration >> renderIn: canvas [
	label := self createLabel.
	location move: label on: canvas encompassingRectangle.
	canvas add: label
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> rotationAngle: anAngleAsFloat [
	"Set the rotation the label should have"
	^ self shape rotateByDegrees: anAngleAsFloat
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> title [
	^ title
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> title: aLabelAsString [
	"This method is useful to set the name of an axis"
	title := aLabelAsString
]

{ #category : 'accessing' }
RSAbstractLabelDecoration >> vertical [
	"Set the label vertical"
	self rotationAngle: -90
]
