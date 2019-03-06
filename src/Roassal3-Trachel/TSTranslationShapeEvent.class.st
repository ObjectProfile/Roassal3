"
When the shape uses translateBy: or translateTo:, position: does not trigger this event
"
Class {
	#name : #TSTranslationShapeEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'step'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSTranslationShapeEvent >> step [
	^ step
]

{ #category : #accessing }
TSTranslationShapeEvent >> step: aPoint [
	step := aPoint
]
