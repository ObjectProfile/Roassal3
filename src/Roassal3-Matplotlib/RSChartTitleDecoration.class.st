Class {
	#name : #RSChartTitleDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSChartTitleDecoration >> renderIn: canvas [
	| label |
	label := RSLabel new text: title; color: Color black.
	canvas addShape: label.
	RSLocation new
		offset: 1;
		above; center;
		stick: label on: self spine.
]

{ #category : #accessing }
RSChartTitleDecoration >> title [
	^ title
]

{ #category : #accessing }
RSChartTitleDecoration >> title: aString [
	title := aString
]
