"
For drag view tests
"
Class {
	#name : #RSDraggableCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
RSDraggableCanvasTest >> setUp [
	view := RSView new.
	view add: (RSShapeBuilder ellipse width: 40; height: 20) element.
	
]

{ #category : #tests }
RSDraggableCanvasTest >> testDefault [
	self assert: view canvas camera position equals: 0@0.
]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeLeft [
	view @ RSDraggableCanvas left.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableCanvas.
	
	view @ RSDraggableCanvas left.
	view canvas announce: (RSMouseDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas ).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (RSMouseLeftDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas ).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeMiddle [
	view @ RSDraggableCanvas middle.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableCanvas.
	
	view @ RSDraggableCanvas middle.
	view canvas announce: (RSMouseDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (RSMouseMiddleDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingModeRight [
	view @ RSDraggableCanvas right.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableCanvas.
	
	view @ RSDraggableCanvas right.
	view canvas announce: (RSMouseDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (RSMouseRightDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingOnDraggable [
	view @ RSDraggableCanvas.
	view canvas announce: (RSMouseDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5))
]

{ #category : #tests }
RSDraggableCanvasTest >> testDraggingOnNotDraggable [
	view canvas announce: (RSMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (0 @ 0)
]
