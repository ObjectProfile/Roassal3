Class {
	#name : 'RSdeCasteljauRationalWoznyChudyLine',
	#superclass : 'RSdeCasteljauWeightedLine',
	#category : 'Roassal3-Shapes-Lines',
	#package : 'Roassal3-Shapes',
	#tag : 'Lines'
}

{ #category : 'accessing' }
RSdeCasteljauRationalWoznyChudyLine >> weight: aNumber atIndex: anIndex [

	^ (super weight: aNumber atIndex: anIndex) * (weights at: anIndex)
]
