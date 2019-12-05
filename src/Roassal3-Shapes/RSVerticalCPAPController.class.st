"
I can return the control points for vertical lines
"
Class {
	#name : #RSVerticalCPAPController,
	#superclass : #RSAbstractCPAPController,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #hooks }
RSVerticalCPAPController >> controlPointsFrom: from to: to [
	| mid |
	mid := (from + to)/2.
	^ Array
		with: from
		with: from x @ mid y
		with: to x @ mid y
		with: to
]
