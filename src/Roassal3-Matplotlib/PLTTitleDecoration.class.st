Class {
	#name : #PLTTitleDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'title'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTTitleDecoration >> renderIn: canvas [
	| label |
	label := RSLabel new text: title; color: Color black.
	canvas addShape: label.
	RSLocation new
		offset: 1;
		above; center;
		stick: label on: self spine.
]

{ #category : #accessing }
PLTTitleDecoration >> title [
	^ title
]

{ #category : #accessing }
PLTTitleDecoration >> title: aString [
	title := aString
]
