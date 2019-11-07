"
When the shape uses translateBy: or translateTo:, position: does not trigger this event
"
Class {
	#name : #RSPositionChangedEvent,
	#superclass : #RSShapeEvent,
	#instVars : [
		'oldPosition',
		'newPosition'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
RSPositionChangedEvent >> newPosition [
	^ newPosition
]

{ #category : #accessing }
RSPositionChangedEvent >> newPosition: anObject [
	newPosition := anObject
]

{ #category : #accessing }
RSPositionChangedEvent >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
RSPositionChangedEvent >> oldPosition: anObject [
	oldPosition := anObject
]
