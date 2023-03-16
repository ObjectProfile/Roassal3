Class {
	#name : #RSAngleLineLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #tests }
RSAngleLineLayoutTest >> testBasic [

	| layout |
	layout := RSAngleLineLayout new.
	self assert: layout angle equals: layout defaultAngle.
	layout angle: 45.
	self assert: layout angle equals: 45
]

{ #category : #tests }
RSAngleLineLayoutTest >> testGapSize [

	| layout var1st var2nd |
	layout := RSAngleLineLayout new gapSize: 100.
	layout on: shapes.
	var1st := shapes first.
	var2nd := shapes second.
	self assert: var1st position closeTo: 2.5 @ 2.5.
	self assert: var2nd position closeTo: 2.5 @ 102.5
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWith0Angle [

	| layout x |
	layout := RSAngleLineLayout new angle: 0.
	layout on: shapes.
	x := 2.5.
	shapes do: [ :each |
		self assert: each position closeTo: x @ 2.5.
		x := x + layout gapSize ]
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWith90Angle [

	| layout y |
	layout := RSAngleLineLayout new.
	layout on: shapes.
	y := 2.5.
	shapes do: [ :each |
		self assert: each position closeTo: 2.5 @ y.
		y := y + layout gapSize ]
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWithThreeElements [

	| layout y |
	layout := RSAngleLineLayout new.
	layout on: #(  ).
	layout on: shapes.
	y := 2.5.
	shapes do: [ :each |
		self assert: each position closeTo: 2.5 @ y.
		y := y + layout gapSize ]
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutwith90Angle [

	| layout |
	layout := RSAngleLineLayout new.
	layout on: #(  ).
	shapes := shapes first: 2.
	layout on: shapes.
	self assert: shapes first position closeTo: 2.5 @ 2.5.
	self assert: shapes second position closeTo: 2.5 @ 7.5
]
