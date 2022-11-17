Class {
	#name : #RSHorizontalTreeLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #tests }
RSAngleLineTest >> testBasic [
| layout |
	layout := RSAngleLineLayout new.
	self assert: layout angle equals: layout defaultAngle.
	layout angle: 45.
	self assert: layout angle equals: 45
]

{ #category : #tests }
RSAngleLineTest >> testLayout[
	| layout |
	layout := RSAngleLineLayout new.
	layout on: #(  ).
	shapes := shapes first: 2.
	layout on: shapes.
	self assert: shapes first position equals: 2.5 @ 2.5.
	self assert: shapes second position equals: 2.5 @ 3.5
]

{ #category : #tests }
RSAngleLineTest >> testLayout[
	| layout |
	layout := RSAngleLineLayout new.
	layout on: #(  ).
	shapes := shapes first: 2.
	layout on: shapes.
	self assert: shapes first position equals: 2.5 @ 2.5.
	self assert: shapes second position equals: 2.5 @ 3.5
]

{ #category : #tests }
RSAngleLineTest >> testLayoutWith0Angle [
	| layout x |
	layout := RSAngleLineLayout new angle: 0.
	layout on: shapes.
	x := 2.5.
	shapes do: [ :each | 
		self assert: each position closeTo: x @ 2.5.
		x := x + 1 ]
    ]
    
    { #category : #tests }
RSAngleLineTest >> 	testLayoutWith90Angle[
  | layout y |
	layout := RSAngleLineLayout new.
	layout on: shapes.
	y := 2.5.
	shapes do: [ :each | 
		self assert: each position closeTo: 2.5 @ y.
		y := y + 1 ]
    ]
  ]
    
    { #category : #tests }
RSAngleLineTest >>  testLayoutWithThreeElements[
  | layout y |
	layout := RSAngleLineLayout new.
	layout on: #(  ).
	layout on: shapes.
	y := 2.5.
	shapes do: [ :each | 
		self assert: each position closeTo: 2.5 @ y.
		y := y + 1 ]
    ]
  ]

