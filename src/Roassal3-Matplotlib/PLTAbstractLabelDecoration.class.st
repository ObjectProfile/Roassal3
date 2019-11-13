Class {
	#name : #PLTAbstractLabelDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTAbstractLabelDecoration >> createLabel [
	^ RSLabel new
		text: title;
		fontSize: 10;
		color: Color black
]

{ #category : #accessing }
PLTAbstractLabelDecoration >> title [
	^ title
]

{ #category : #accessing }
PLTAbstractLabelDecoration >> title: aLabelAsString [
	"This method is useful to set the name of an axis"
	title := aLabelAsString
]
