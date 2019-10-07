Class {
	#name : #RSControlsViewTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| view |
	view := RSView new.
	view @ RSControlsView
]
