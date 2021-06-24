Class {
	#name : #RSControlsViewTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| canvas controller |
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	controller := canvas controllerInteraction.
	self assert: controller class equals: RSCanvasController.
	canvas @ RSCanvasController.
	self assert: controller equals: canvas controllerInteraction.
	
]
