Class {
	#name : #RSControlsViewTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| canvas |
	canvas := RSCanvas new.
	canvas @ RSCanvasController
]
