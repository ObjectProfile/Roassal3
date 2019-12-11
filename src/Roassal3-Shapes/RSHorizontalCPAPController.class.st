"
I can return the control points for horizontal lines
"
Class {
	#name : #RSHorizontalCPAPController,
	#superclass : #RSAbstractCPAPController,
	#category : #'Roassal3-Shapes-CP'
}

{ #category : #hooks }
RSHorizontalCPAPController >> controlPointsFrom: from to: to [
	| mid |
	mid := (from + to)/2.
	^ Array 
		with: from
		with: mid x @ from y
		with: mid x @ to y
		with: to 
]
