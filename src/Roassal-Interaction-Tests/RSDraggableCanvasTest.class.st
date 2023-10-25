"
For drag view tests
"
Class {
	#name : 'RSDraggableCanvasTest',
	#superclass : 'RSTest',
	#instVars : [
		'canvas',
		'camera'
	],
	#category : 'Roassal-Interaction-Tests-Core',
	#package : 'Roassal-Interaction-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
RSDraggableCanvasTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	canvas add: (RSEllipse new width: 40; height: 20; yourself).
	camera := canvas camera
]

{ #category : 'tests' }
RSDraggableCanvasTest >> testDefault [
	self assert: canvas canvas camera position equals: 0@0
]

{ #category : 'tests' }
RSDraggableCanvasTest >> testDraggingModeLeft [
	| class |
	class := RSDraggableCanvasInteraction.
	{#left. RSMouseLeftDragStart.
	#right. RSMouseRightDragStart.
	#middle. RSMouseMiddleDragStart} pairsDo: [ :selector :eventClass|
		canvas @ (selector value: class).
		canvas canvas announce: (RSMouseDragging new step: 10 @ 5).
		self assert: camera position closeTo: 0 @ 0.

		canvas removeInteractionIfPresent: class.

		canvas @ (selector value: class).
		canvas announce: RSMouseDragStart new.
		canvas announce: (RSMouseDragging new step: 10 @ 5).
		canvas announce: RSMouseDragEnd new.
		self assert: camera position closeTo: 0 @ 0.

		canvas announce: eventClass new.
		canvas announce: (RSMouseDragging new step: 10 @ 5).
		canvas announce: RSMouseDragEnd new.
		self assert: camera position closeTo: (10 @ 5).
		canvas removeInteractionIfPresent: class.
		camera position: 0@0.
		]
]

{ #category : 'tests' }
RSDraggableCanvasTest >> testDraggingOnDraggable [
	canvas @ RSDraggableCanvasInteraction.
	canvas announce: RSMouseDragStart new.
	canvas announce: (RSMouseDragging new step: 10 @ 5).
	canvas announce: RSMouseDragEnd new.
	self assert: camera position closeTo: 10 @ 5
]

{ #category : 'tests' }
RSDraggableCanvasTest >> testDraggingOnNotDraggable [
	canvas announce: (RSMouseDragging step: 10 @ 5).
	self assert: camera position equals: (0 @ 0)
]
