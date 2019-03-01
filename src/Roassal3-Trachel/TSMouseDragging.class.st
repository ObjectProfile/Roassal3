"
When: during dragging of the element
Target: dragged element
"
Class {
	#name : #TSMouseDragging,
	#superclass : #TSAbstractMouseEvent,
	#instVars : [
		'step'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #'instance creation' }
TSMouseDragging class >> step: aStepAsPoint [
	^ self new step: aStepAsPoint
]

{ #category : #'initialize - release' }
TSMouseDragging >> initialize [
	super initialize.
	step := 0 @ 0.
]

{ #category : #accessing }
TSMouseDragging >> step [
	^ step
]

{ #category : #accessing }
TSMouseDragging >> step: aPoint [
	step := aPoint
]
