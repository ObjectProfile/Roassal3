Class {
	#name : #RSShapeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Shapes'
}

{ #category : #tests }
RSShapeTest >> testTranslateMiddleRightTo [

	| c center lbl |
	c := RSCanvas new.

	center := RSEllipse new size: 2; color: Color red.
	c add: center.
	center translateTo: 0 @ 0.

	lbl := RSLabel text: 'Middle right corner'.
	c add: lbl.
	lbl translateMiddleRightTo: 0 @ 0.
	
	self assert: (lbl position closeTo: (-52.40666 @ 0))
]
