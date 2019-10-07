"
I'm a mouse wheel scrolling event.

"
Class {
	#name : #TSMouseWheelEvent,
	#superclass : #TSAbstractMouseEvent,
	#instVars : [
		'direction'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
TSMouseWheelEvent >> direction [
	^ direction
]

{ #category : #accessing }
TSMouseWheelEvent >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
TSMouseWheelEvent >> isDown [
	^ direction = Character arrowDown
]

{ #category : #testing }
TSMouseWheelEvent >> isLeft [
	^ direction = Character arrowLeft
]

{ #category : #testing }
TSMouseWheelEvent >> isRight [
	^ direction = Character arrowRight
]

{ #category : #testing }
TSMouseWheelEvent >> isUp [
	^ direction = Character arrowUp
]
