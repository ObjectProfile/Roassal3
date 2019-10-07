"
When the shape uses translateBy: or translateTo:, position: does not trigger this event
"
Class {
	#name : #TSPositionChangedEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'oldPosition',
		'newPosition'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
TSPositionChangedEvent >> newPosition [
	^ newPosition
]

{ #category : #accessing }
TSPositionChangedEvent >> newPosition: anObject [
	newPosition := anObject
]

{ #category : #accessing }
TSPositionChangedEvent >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
TSPositionChangedEvent >> oldPosition: anObject [
	oldPosition := anObject
]
