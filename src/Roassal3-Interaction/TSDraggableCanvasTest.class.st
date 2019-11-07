"
For drag view tests
"
Class {
	#name : #TSDraggableCanvasTest,
	#superclass : #RSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #running }
TSDraggableCanvasTest >> setUp [
	view := RSView new.
	view add: (RSShapeBuilder ellipse width: 40; height: 20) element.
	
]

{ #category : #tests }
TSDraggableCanvasTest >> testDefault [
	self assert: view canvas camera position equals: 0@0.
]

{ #category : #tests }
TSDraggableCanvasTest >> testDraggingModeLeft [
	view @ TSDraggableCanvas left.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: TSDraggableCanvas.
	
	view @ TSDraggableCanvas left.
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
TSDraggableCanvasTest >> testDraggingModeMiddle [
	view @ TSDraggableCanvas middle.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: TSDraggableCanvas.
	
	view @ TSDraggableCanvas middle.
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
TSDraggableCanvasTest >> testDraggingModeRight [
	view @ TSDraggableCanvas right.
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: TSDraggableCanvas.
	
	view @ TSDraggableCanvas right.
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
TSDraggableCanvasTest >> testDraggingOnDraggable [
	view @ TSDraggableCanvas.
	view canvas announce: (RSMouseDragStart new canvas: view canvas).
	view canvas announce: (RSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (RSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5))
]

{ #category : #tests }
TSDraggableCanvasTest >> testDraggingOnNotDraggable [
	view canvas announce: (RSMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (0 @ 0)
]
