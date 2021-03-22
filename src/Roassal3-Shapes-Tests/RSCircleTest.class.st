Class {
	#name : #RSCircleTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSCircleTest >> testBasic [

	self assert: (RSCircle new extent) equals: 10 @ 10
]
