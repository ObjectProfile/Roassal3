"
When: during dragging of the element
Target: dragged element
"
Class {
	#name : #RSMouseDragging,
	#superclass : #RSAbstractMouseEvent,
	#instVars : [
		'step'
	],
	#category : #'Roassal3-Event'
}

{ #category : #'instance creation' }
RSMouseDragging class >> step: aStepAsPoint [
	^ self new step: aStepAsPoint
]

{ #category : #initialization }
RSMouseDragging >> initialize [
	super initialize.
	step := 0 @ 0
]

{ #category : #accessing }
RSMouseDragging >> step [
	^ step
]

{ #category : #accessing }
RSMouseDragging >> step: aPoint [
	step := aPoint
]
