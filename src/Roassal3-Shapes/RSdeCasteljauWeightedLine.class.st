Class {
	#name : 'RSdeCasteljauWeightedLine',
	#superclass : 'RSdeCasteljauLine',
	#instVars : [
		'weights'
	],
	#category : 'Roassal3-Shapes-Lines',
	#package : 'Roassal3-Shapes',
	#tag : 'Lines'
}

{ #category : 'instance creation' }
RSdeCasteljauWeightedLine >> newLine [

	^ super newLine
		  weights: weights;
		  yourself
]

{ #category : 'accessing' }
RSdeCasteljauWeightedLine >> weights: anObject [

	weights := anObject
]
