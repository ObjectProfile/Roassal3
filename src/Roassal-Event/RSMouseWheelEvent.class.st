"
I'm a mouse wheel scrolling event.

"
Class {
	#name : #RSMouseWheelEvent,
	#superclass : #RSAbstractMouseEvent,
	#instVars : [
		'direction'
	],
	#category : #'Roassal3-Event'
}

{ #category : #accessing }
RSMouseWheelEvent >> direction [
	^ direction
]

{ #category : #accessing }
RSMouseWheelEvent >> direction: anObject [
	direction := anObject
]

{ #category : #testing }
RSMouseWheelEvent >> isDown [
	^ direction = Character arrowDown
]

{ #category : #testing }
RSMouseWheelEvent >> isLeft [
	^ direction = Character arrowLeft
]

{ #category : #testing }
RSMouseWheelEvent >> isRight [
	^ direction = Character arrowRight
]

{ #category : #testing }
RSMouseWheelEvent >> isUp [
	^ direction = Character arrowUp
]
