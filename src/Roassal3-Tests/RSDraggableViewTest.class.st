"
For drag view tests
"
Class {
	#name : #RSDraggableViewTest,
	#superclass : #TSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Tests-Interactions'
}

{ #category : #running }
RSDraggableViewTest >> setUp [
	view := RSView new.
	view add: (RSShapeBuilder ellipse width: 40; height: 20) element.
	
]

{ #category : #tests }
RSDraggableViewTest >> testDefault [
	self assert: view canvas camera position equals: 0@0.
]

{ #category : #tests }
RSDraggableViewTest >> testDraggingModeLeft [
	view @ RSDraggableView2 left.
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableView2.
	
	view @ RSDraggableView2 left.
	view canvas announce: (TSMouseDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas ).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (TSMouseLeftDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas ).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableViewTest >> testDraggingModeMiddle [
	view @ RSDraggableView2 middle.
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableView2.
	
	view @ RSDraggableView2 middle.
	view canvas announce: (TSMouseDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (TSMouseMiddleDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableViewTest >> testDraggingModeRight [
	view @ RSDraggableView2 right.
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view removeInteractionIfPresent: RSDraggableView2.
	
	view @ RSDraggableView2 right.
	view canvas announce: (TSMouseDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (0 @ 0)).
	
	view canvas announce: (TSMouseRightDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5)).


]

{ #category : #tests }
RSDraggableViewTest >> testDraggingOnDraggable [
	view @ RSDraggableView2.
	view canvas announce: (TSMouseDragStart new canvas: view canvas).
	view canvas announce: (TSMouseDragging new step: 10 @ 5; canvas: view canvas).
	view canvas announce: (TSMouseDragEnd new canvas: view canvas).
	self assert: (view canvas camera position closeTo: (-10 @ -5))
]

{ #category : #tests }
RSDraggableViewTest >> testDraggingOnNotDraggable [
	view canvas announce: (TSMouseDragging step: 10 @ 5).
	self assert: view canvas camera position = (0 @ 0)
]
