"
For drag view tests
"
Class {
	#name : #RSDraggableCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
RSDraggableCanvasTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	canvas add: (RSEllipse new width: 40; height: 20; yourself).
	
]

{ #category : #tests }
RSDraggableCanvasTest >> testDefault [
	self assert: canvas canvas camera position equals: 0@0.
]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeLeft [
	canvas @ RSDraggableCanvasInteraction left.
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas removeInteractionIfPresent: RSDraggableCanvasInteraction.
	
	canvas @ RSDraggableCanvasInteraction left.
	canvas canvas announce: (RSMouseDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas ).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas canvas announce: (RSMouseLeftDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas ).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeMiddle [
	canvas @ RSDraggableCanvasInteraction middle.
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas removeInteractionIfPresent: RSDraggableCanvasInteraction.
	
	canvas @ RSDraggableCanvasInteraction middle.
	canvas canvas announce: (RSMouseDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas canvas announce: (RSMouseMiddleDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeRight [
	canvas @ RSDraggableCanvasInteraction right.
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas removeInteractionIfPresent: RSDraggableCanvasInteraction.
	
	canvas @ RSDraggableCanvasInteraction right.
	canvas canvas announce: (RSMouseDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (0 @ 0)).
	
	canvas canvas announce: (RSMouseRightDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingOnDraggable [
	canvas @ RSDraggableCanvasInteraction.
	canvas canvas announce: (RSMouseDragStartEvent new canvas: canvas canvas).
	canvas canvas announce: (RSMouseDraggingEvent new step: 10 @ 5; canvas: canvas canvas).
	canvas canvas announce: (RSMouseDragEndEvent new canvas: canvas canvas).
	self assert: (canvas canvas camera position closeTo: (-10 @ -5))
]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingOnNotDraggable [
	canvas canvas announce: (RSMouseDraggingEvent step: 10 @ 5).
	self assert: canvas canvas camera position = (0 @ 0)
]
