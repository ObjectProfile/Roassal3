Class {
	#name : #RSControlsViewTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| view |
	view := RSView new.
	view @ RSCanvasController
]
