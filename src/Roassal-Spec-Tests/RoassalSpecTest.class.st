Class {
	#name : #RoassalSpecTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Spec-Tests'
}

{ #category : #tests }
RoassalSpecTest >> isValid [
	^ Smalltalk globals includesKey: #SpRoassalPresenter
]

{ #category : #tests }
RoassalSpecTest >> testBasic [
	| spec value window |
	self isValid ifFalse: [ ^ self ].
	spec := SpRoassalPresenter new.
	window := spec asWindow open.
	value := 0.

	spec script: [ :view | view addShape: RSBox new. value := value + 1 ].
	self assert: value equals: 1.
	spec script: [ :view | view addShape: RSBox new. value := 0 ].
	self assert: value equals: 0.
	window close
]

{ #category : #tests }
RoassalSpecTest >> testTakeKeyboardFocus [
	| spec window canvas window2 |
	self isValid ifFalse: [ ^ self ].
	canvas := RSCanvas new
		add: (RSBox new size: 100);
		@ RSCanvasController;
		yourself.
	spec := SpRoassal3InspectorPresenter new.
	spec canvas: canvas.
	window := spec open.
	window2 := StPlayground new open.
	self deny: canvas morph hasKeyboardFocus.
	canvas morph mouseDown: (MouseButtonEvent new
		setType: nil
		position: canvas morph center
		which: MouseButtonEvent yellowButton
		buttons: MouseButtonEvent yellowButton
		hand: canvas morph activeHand
		stamp: nil).
	self assert: canvas morph hasKeyboardFocus.
	window delete.
	window2 delete
]
