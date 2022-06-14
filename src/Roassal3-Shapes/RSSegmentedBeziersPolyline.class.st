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

	| random yDistance |
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
			| cornerRadius firstSegment secondSegments thirdSegment aPoint aCorner anotherCorner |
			aCollectionOfPoints first y < aCollectionOfPoints last y
				ifTrue: [ "Going down."
					| topRight bottomLeft |
					topRight := self
						            cornerRadiusAmongPoint: aCollectionOfPoints first
						            andPoint: aCollectionOfPoints second.

					bottomLeft := self
						              cornerRadiusAmongPoint: aCollectionOfPoints third
						              andPoint: aCollectionOfPoints fourth.

					cornerRadius := RSCornerRadius new
						                topRight: topRight;
						                bottomLeft: bottomLeft;
						                yourself.

					aCorner := cornerRadius
						           asBezierTopRightPoint: aCollectionOfPoints second
						           random: random.

					anotherCorner := (cornerRadius
						                  asBezierBottomLeftPoint:
						                  aCollectionOfPoints third
						                  random: random) reversed ]
				ifFalse: [ "Going up."
					| bottomRight topLeft |
					bottomRight := self
						               cornerRadiusAmongPoint: aCollectionOfPoints first
						               andPoint: aCollectionOfPoints second.

					topLeft := self
						           cornerRadiusAmongPoint: aCollectionOfPoints third
						           andPoint: aCollectionOfPoints fourth.

					cornerRadius := RSCornerRadius new
						                bottomRight: bottomRight;
						                topLeft: topLeft;
						                yourself.

					aCorner := (cornerRadius
						            asBezierBottomRightPoint: aCollectionOfPoints second
						            random: random) reversed.

					anotherCorner := cornerRadius
						                 asBezierTopLeftPoint: aCollectionOfPoints third
						                 random: random ].

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

	^ (((aPoint distanceTo: anotherPoint) max: 2) log: 2) "max:
		  self cornerRadii"
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
