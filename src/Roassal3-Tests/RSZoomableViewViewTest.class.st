"
for zoom with the wheel
"
Class {
	#name : #RSZoomableViewViewTest,
	#superclass : #TSTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal3-Tests-Interactions'
}

{ #category : #running }
RSZoomableViewViewTest >> setUp [
	view := RSView new.
	view add: (RSShapeBuilder box width: 40; height: 20) element.
	
]

{ #category : #running }
RSZoomableViewViewTest >> testDefault [
	self assert: view camera position equals: 0@0.
	view @ RSZoomableView.
	self assert: view camera position equals: 0@0.
	view canvas announce: (TSMouseWheelEvent new 
		direction: Character arrowUp; 
		position: 0@0;
		canvas: view canvas).

	self assert: (view canvas camera position closeTo: (0 @ 0)).
	self assert: (view canvas camera scale > 1).
]
