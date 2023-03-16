Class {
	#name : #RSCanvasControllerTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #accessing }
RSCanvasControllerTest >> classToTest [
	^ RSCanvasController
]

{ #category : #tests }
RSCanvasControllerTest >> testBasic [
	| canvas controller |
	canvas := RSCanvas new.
	canvas @ self classToTest.
	controller := canvas controllerInteraction.
	self assert: controller class equals: self classToTest.
	canvas @ self classToTest.
	self assert: controller equals: canvas controllerInteraction.
	self assert: canvas fixedShapes size equals: 3
]

{ #category : #tests }
RSCanvasControllerTest >> testNoLegend [
	| canvas controller |
	canvas := RSCanvas new.
	controller := self classToTest new.
	controller noLegend.
	canvas addInteraction: controller.
	self assert: canvas fixedShapes size equals: 2
]

{ #category : #tests }
RSCanvasControllerTest >> testZoomToFitOnStart [
	| canvas box controller window scale |
	canvas := RSCanvas new.
	box := RSBox new
		position: 1000 asPoint;
		extent: 100 asPoint;
		yourself.
	canvas add: box.
	controller := self classToTest new.
	canvas addInteraction: controller.
	self assert: canvas position equals: 0@0.
	window := canvas open.
	window delete.
	canvas morph drawOnMockCanvas.
	self assert: canvas position equals: box position.
	scale := canvas camera scale.
	canvas extent: 100@100.
	self assert: canvas position equals: box position.
	self assert: scale equals: canvas camera scale
]
