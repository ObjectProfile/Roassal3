"
When: during dragging of the element
Target: dragged element
"
Class {
	#name : #RSMouseDraggingEvent,
	#superclass : #RSAbstractMouseEvent,
	#instVars : [
		'step'
	],
	#category : #'Roassal3-Events'
}

{ #category : #'instance creation' }
RSMouseDraggingEvent class >> step: aStepAsPoint [
	^ self new step: aStepAsPoint
]

{ #category : #'initialize - release' }
RSMouseDraggingEvent >> initialize [
	super initialize.
	step := 0 @ 0.
]

{ #category : #accessing }
RSMouseDraggingEvent >> step [
	^ step
]

{ #category : #accessing }
RSMouseDraggingEvent >> step: aPoint [
	step := aPoint
]
