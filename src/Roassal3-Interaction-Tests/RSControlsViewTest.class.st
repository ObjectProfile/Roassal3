Class {
	#name : #RSControlsViewTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| canvas controller |
	canvas := RSCanvas new.
	canvas @ RSCanvasControllerInteraction.
	controller := canvas controllerInteraction.
	self assert: controller class equals: RSCanvasControllerInteraction.
	canvas @ RSCanvasControllerInteraction.
	self assert: controller equals: canvas controllerInteraction.
	
]
