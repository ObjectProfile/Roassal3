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

	| lines newSplits |
	lines := aCollectionOfArrays collect: lineBlock.

	splits := lines
		          collect: [ :aLine | 
			          aLine splitWhile: [ :aBezier | 
				          aBezier overlappingControlPointsDistance > 100
					          ifTrue: [ 1 / 2 ]
					          ifFalse: [ nil ] ] ]
		          as: OrderedCollection.

	newSplits := OrderedCollection new.

	splits overlappingPairsDo: [ :aSplit :anotherSplit | 
		| aBezier right innerSplits junctionBezier |
		junctionBezier := anotherSplit first.

		right := RSdeCasteljauLine new
			         samplesLinspace: junctionBezier parameterization size;
			         controlPoints: { 
					         junctionBezier designPoints first.
					         junctionBezier designPoints first };
			         yourself.

		aBezier := junctionBlock value: aSplit last value: right.

		innerSplits := aBezier splitWhile: [ :eachBezier | 
			               eachBezier overlappingControlPointsDistance > 100
				               ifTrue: [ 1 / 2 ]
				               ifFalse: [ nil ] ].

		newSplits add: innerSplits

		"innerSplits reverseDo: [ :each | anotherSplit addFirst: each ] " ].

	splits addAll: newSplits
]

{ #category : #accessing }
RSSegmentedBeziersPolyline >> splits [

	^ splits
]
