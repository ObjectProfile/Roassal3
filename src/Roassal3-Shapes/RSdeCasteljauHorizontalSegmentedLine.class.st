Class {
	#name : #RSdeCasteljauHorizontalSegmentedLine,
	#superclass : #RSPolyline,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauHorizontalSegmentedLine >> controlPoints: aCollectionOfArrays [

	| beziers first points |
	beziers := aCollectionOfArrays collect: [ :anArrayOfPoints | 
		           RSdeCasteljauLine new
			           samples: 50;
			           controlPoints: anArrayOfPoints;
			           yourself ].

	first := beziers first.

	points := first controlPoints.

	beziers size > 1 ifTrue: [ 
		| second third |
		second := first junction: beziers second right: [ :c0 :c1 :c2 | c1 ].
		third := second junction: beziers third right: [ :c0 :c1 :c2 | c1 ].
		points := points , second controlPoints , third controlPoints ].

	^ super controlPoints: points
]
