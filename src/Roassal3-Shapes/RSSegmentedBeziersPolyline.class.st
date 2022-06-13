Class {
	#name : #RSSegmentedBeziersPolyline,
	#superclass : #RSPolyline,
	#instVars : [
		'splits'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSSegmentedBeziersPolyline >> buildPathOn: visitor [

	visitor buildSegmentedBeziersPolylinePath: self
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> controlPoints: aCollectionOfPoints [

	| first second third fourth aCorner anotherCorner cornerRadii direction random firstSegment secondSegments thirdSegment yDistance aPoint |
	random := RandomBoxMullerBivariateGaussian new.
	splits := OrderedCollection new.

	yDistance := (aCollectionOfPoints first y
	              - aCollectionOfPoints last y) abs.

	yDistance < (self cornerRadii * 2)
		ifTrue: [ 
			| aBezier midPoint |
			midPoint := aCollectionOfPoints first
				            unitAffine: aCollectionOfPoints last
				            at: 1 / 2.

			aBezier := RSBezier new
				           controlPoints: { 
						           aCollectionOfPoints first.
						           (midPoint + random next).
						           aCollectionOfPoints last };
				           yourself.

			splits add: aBezier ]
		ifFalse: [ 
			direction := aCollectionOfPoints first y
			             < aCollectionOfPoints last y
				             ifTrue: [ 1 ]
				             ifFalse: [ -1 ].

			cornerRadii := self
				               cornerRadiusAmongPoint: aCollectionOfPoints first
				               andPoint: aCollectionOfPoints second.

			first := aCollectionOfPoints second - (cornerRadii @ 0).
			second := first + (cornerRadii halved @ 0).

			cornerRadii := self
				               cornerRadiusAmongPoint: aCollectionOfPoints second
				               andPoint: aCollectionOfPoints third.

			third := aCollectionOfPoints second
			         + (0 @ (cornerRadii halved * direction)).
			fourth := third + (0 @ (cornerRadii halved * direction)).

			aCorner := RSBezier new
				           controlPoints: { 
						           (first + (random next * Float silverRatio)).
						           (second + (random next abs * (1 @ direction negated))).
						           (third + (random next abs * (1 @ direction negated))).
						           (fourth + (random next * Float silverRatio)) };
				           yourself.

			first := aCollectionOfPoints third
			         - (0 @ (cornerRadii * direction)).
			second := first + (0 @ (cornerRadii halved * direction)).

			cornerRadii := self
				               cornerRadiusAmongPoint: aCollectionOfPoints third
				               andPoint: aCollectionOfPoints fourth.

			third := aCollectionOfPoints third + (cornerRadii halved @ 0).
			fourth := third + (cornerRadii halved @ 0).

			anotherCorner := RSBezier new
				                 controlPoints: { 
						                 (first + (random next * Float silverRatio)).
						                 (second + (random next abs * (-1 @ direction))).
						                 (third + (random next abs * (-1 @ direction))).
						                 (fourth + (random next * Float silverRatio)) };
				                 yourself.

			aPoint := aCorner firstC1Point.

			firstSegment := RSBezier new
				                controlPoints: { 
						                aCollectionOfPoints first.
						                ((aCollectionOfPoints first
							                  unitAffine: aPoint
							                  at: 1 / 2) + random next).
						                aPoint.
						                aCorner controlPoints first };
				                yourself.

			secondSegments := (aCorner joinC1Last: anotherCorner)
				                  splitYrandom: random
				                  convex: -1
				                  lessThanBound: self cornerRadii * 3.

			secondSegments ifEmpty: [ 
				| cps |
				cps := Array new: 4.

				cps
					at: 1 put: aCorner controlPoints last;
					at: 2 put: aCorner lastC1Point;
					at: 3 put: anotherCorner controlPoints third;
					at: 4 put: anotherCorner controlPoints fourth.

				anotherCorner controlPoints: cps ].

			aPoint := anotherCorner lastC1Point.

			thirdSegment := RSBezier new
				                controlPoints: { 
						                anotherCorner controlPoints last.
						                aPoint.
						                ((aPoint
							                  unitAffine: aCollectionOfPoints last
							                  at: 1 / 2) + random next).
						                aCollectionOfPoints last };
				                yourself.

			splits
				add: firstSegment;
				add: aCorner;
				addAll: secondSegments;
				add: anotherCorner;
				add: thirdSegment ].

	super controlPoints: aCollectionOfPoints
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> cornerRadiusAmongPoint: aPoint andPoint: anotherPoint [

	^ (((aPoint distanceTo: anotherPoint) max: 2) log: 2) max:
		  self cornerRadii
]

{ #category : #initialization }
RSSegmentedBeziersPolyline >> initialize [

	super initialize.

	self cornerRadii: 5
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> splits [

	^ splits
]
