Class {
	#name : #RSSegmentedBeziersPolyline,
	#superclass : #RSSegmentedPolyline,
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
RSSegmentedBeziersPolyline >> controlPoints: aCollectionOfArrays [

	| lines |
	lines := aCollectionOfArrays collect: lineBlock.

	splits := lines collect: [ :aLine | 
		          aLine splitWhile: [ :aBezier | 
			          aBezier overlappingControlPointsDistance > 100
				          ifTrue: [ 1 / 2 ]
				          ifFalse: [ nil ] ] ].

	splits overlappingPairsDo: [ :aSplit :anotherSplit | 
		| aBezier right innerSplits junctionBezier |
		junctionBezier := anotherSplit first.

		right := RSdeCasteljauLine new
			         samples: junctionBezier parameterization size;
			         controlPoints: { 
					         junctionBezier designPoints first.
					         junctionBezier designPoints first };
			         yourself.

		aBezier := junctionBlock value: aSplit last value: right.

		innerSplits := aBezier splitWhile: [ :eachBezier | 
			               eachBezier overlappingControlPointsDistance > 100
				               ifTrue: [ 1 / 2 ]
				               ifFalse: [ nil ] ].

		innerSplits reverseDo: [ :each | anotherSplit addFirst: each ] ]
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> splits [

	^ splits
]
