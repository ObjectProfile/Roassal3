"
TODO
"
Class {
	#name : #RSChartTitleDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #rendering }
RSChartTitleDecoration >> defaultFontSize [
	^ 15
]

{ #category : #rendering }
RSChartTitleDecoration >> initialize [
	super initialize.
	self fontSize: self defaultFontSize.
	self rotationAngle: 0
]

{ #category : #rendering }
RSChartTitleDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas add: label.
	RSLocation new
		offset: 1;
		above; center;
		stick: label on: self spine.
]
