Class {
	#name : #PLTTitleDecoration,
	#superclass : #PLTDecoration,
	#instVars : [
		'title'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTTitleDecoration >> renderIn: canvas [
	| label |
	label := TSLabel new text: title; color: Color black.
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
