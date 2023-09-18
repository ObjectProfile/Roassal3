Class {
	#name : #RSFlowLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSFlowLayoutTest >> testLinesEven [
	| layout lines line n |
	layout := RSFlowLayout new.
	layout maxWidth: 20.
	lines := layout linesFor: shapes.
	n := 5.
	self assert: lines size equals: n.
	line := lines last.
	"all shapes has the same size"

	self
		assert: line first position y
		equals: (layout gapSize* n)+(shapes first height * (n-1.5))
]

{ #category : #tests }
RSFlowLayoutTest >> testLinesOdd [
	| layout lines line n |
	layout := RSFlowLayout new.
	layout maxWidth: 30.
	layout on: shapes.
	lines := layout linesFor: shapes.
	n := 4.
	self assert: lines size equals: n.
	line := lines last.
	"all shapes has the same size"

	self
		assert: line first position y
		equals: (layout gapSize* n)+(shapes first height * (n-1.5))
]
