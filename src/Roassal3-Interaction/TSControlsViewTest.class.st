Class {
	#name : #TSControlsViewTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #tests }
TSControlsViewTest >> testBasic [
	| view |
	view := RSView new.
	view @ TSControlsCanvas
]
