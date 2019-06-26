Class {
	#name : #RSControlsViewTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #tests }
RSControlsViewTest >> testBasic [
	| view |
	view := RSView new.
	view @ RSControlsView
]
