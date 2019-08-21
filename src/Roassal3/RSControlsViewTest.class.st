Class {
	#name : #RSControlsViewTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Test'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| view |
	view := RSView new.
	view @ RSControlsView
]
