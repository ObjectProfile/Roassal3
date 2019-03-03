"
When the shape uses translateBy: or translateTo:, position: does not trigger this event
"
Class {
	#name : #TSTranslationEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'step'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSTranslationEvent >> step [
	^ step
]

{ #category : #accessing }
TSTranslationEvent >> step: aPoint [
	step := aPoint
]
