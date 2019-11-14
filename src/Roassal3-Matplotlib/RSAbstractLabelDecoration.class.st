Class {
	#name : #RSAbstractLabelDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSAbstractLabelDecoration >> createLabel [
	^ RSLabel new
		text: title;
		fontSize: 10;
		color: Color black
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
