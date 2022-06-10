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

	| first second third fourth aCorner anotherCorner cornerRadii direction random firstSegment secondSegment thirdSegment |
	random := RandomBoxMullerBivariateGaussian new.
	splits := OrderedCollection new.

	(aCollectionOfPoints first y - aCollectionOfPoints last y) abs
	< (5 * Float goldenRatio)
		ifTrue: [ 
			splits add: (RSBezier new
					 controlPoints: { 
							 aCollectionOfPoints first.
							 (aCollectionOfPoints first + aCollectionOfPoints last / 2
							  + random next).
							 aCollectionOfPoints last };
					 yourself) ]
		ifFalse: [ 
			direction := aCollectionOfPoints first y
			             < aCollectionOfPoints last y
				             ifTrue: [ 1 ]
				             ifFalse: [ -1 ].

			"	cornerRadii := ((self
		                 cornerRadiusAmongPoint: aCollectionOfPoints first
		                 andPoint: aCollectionOfPoints second) max: (self
			                 cornerRadiusAmongPoint: aCollectionOfPoints second
			                 andPoint: aCollectionOfPoints third)) max: (self
			                cornerRadiusAmongPoint: aCollectionOfPoints third
			                andPoint: aCollectionOfPoints fourth).
"
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

			firstSegment := RSBezier new
				                controlPoints: { 
						                aCollectionOfPoints first.
						                (aCollectionOfPoints first
						                 +
							                 (aCorner controlPoints second reflectedAbout:
									                  aCorner controlPoints first) / 2
						                 + random next).
						                (aCorner controlPoints second reflectedAbout:
								                 aCorner controlPoints first).
						                aCorner controlPoints first };
				                yourself.

			secondSegment := RSBezier new
				                 controlPoints: { 
						                 aCorner controlPoints last.
						                 (aCorner controlPoints lastButOne 
							                  reflectedAbout: aCorner controlPoints last).
						                 (anotherCorner controlPoints second 
							                  reflectedAbout:
								                  anotherCorner controlPoints first).
						                 anotherCorner controlPoints first };
				                 yourself.

			thirdSegment := RSBezier new
				                controlPoints: { 
						                anotherCorner controlPoints last.
						                (anotherCorner controlPoints lastButOne 
							                 reflectedAbout:
								                 anotherCorner controlPoints last).
						                ((anotherCorner controlPoints lastButOne 
							                  reflectedAbout:
								                  anotherCorner controlPoints last)
						                 + aCollectionOfPoints last / 2 + random next).
						                aCollectionOfPoints last };
				                yourself.

			splits
				add: firstSegment;
				add: aCorner;
				add: secondSegment;
				add: anotherCorner;
				add: thirdSegment ].

	super controlPoints: aCollectionOfPoints
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> cornerRadiusAmongPoint: aPoint andPoint: anotherPoint [

	^ ((aPoint distanceTo: anotherPoint) max: 1) log: 2
]

{ #category : #initialization }
RSSegmentedBeziersPolyline >> initialize [

	super initialize.

	self cornerRadii: 20
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> splits [

	^ splits
]
