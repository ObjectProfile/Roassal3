Class {
	#name : #RSDraggableTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSDraggableTest >> testBasic [
	| box |
	box := RSBox new.
	box @ RSDraggable
]

{ #category : #tests }
RSDraggableTest >> testCheckChildrenActions [
	| box composite |
	box := RSBox new model: 'foo'; popup; yourself.
	composite := { box } asShape.
	self should: [ composite draggable ] raise: Error
]

{ #category : #tests }
RSDraggableTest >> testDisableCheckChildrenActions [
	| box composite draggable |
	box := RSBox new model: 'foo'; popup; yourself.
	composite := { box } asShape.
	draggable := RSDraggable new.
	draggable noValidateChildrenEvents.
	composite @ draggable
]
