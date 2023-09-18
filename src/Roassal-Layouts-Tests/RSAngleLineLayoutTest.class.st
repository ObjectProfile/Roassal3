Class {
	#name : #RSAngleLineLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSAngleLineLayoutTest >> testBasic [

	| layout angle |
	layout := RSAngleLineLayout new.
	self assert: layout angle equals: layout defaultAngle.
	angle := 45 degreesToRadians.
	layout angle: angle.
	self assert: layout angle equals: angle
]

{ #category : #tests }
RSAngleLineLayoutTest >> testGapSize [

	| layout var1st var2nd |
	layout := RSAngleLineLayout new gapSize: 100.
	layout on: shapes.
	var1st := shapes first.
	var2nd := shapes second.
	self assert: var1st position closeTo: 2.5 @ 2.5.
	self assert: var2nd position closeTo: 107.5 @ 2.5
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWith0Angle [

	| layout x gap |
	layout := RSAngleLineLayout new angle: 0.
	gap := layout gapSize.
	layout on: shapes.
	x := 2.5.
	shapes do: [ :each |
		self assert: each position closeTo: x @ 2.5.
		x := x + each width + gap ]
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWith90Angle [

	| layout y gap |
	layout := RSAngleLineLayout new.
	layout angleByDegrees: 90.
	gap := layout gapSize.
	layout on: shapes.
	y := 2.5.
	shapes do: [ :each |
		self assert: each position closeTo: 2.5 @ y.
		y := y + each height + gap ]
]

{ #category : #tests }
RSAngleLineLayoutTest >> testLayoutWithThreeElements [
	| layout gap extent |
	layout := RSAngleLineLayout new.
	gap := layout gapSize.
	shapes := shapes first: 3.
	extent := shapes first extent.
	layout on: shapes.
	self assert: shapes first position equals: extent * (0.5@ 0.5).
	self assert: shapes second position equals: extent * (1.5 @ 0.5) + (gap@0).
	self assert: shapes third position equals: extent * (2.5 @ 0.5) + (gap*2@0).
]
