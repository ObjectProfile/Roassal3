Class {
	#name : #RSdeCasteljauRationalWoznyChudyLine,
	#superclass : #RSdeCasteljauWeightedLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalWoznyChudyLine >> weight: aNumber atIndex: anIndex [

	^ (super weight: aNumber atIndex: anIndex) * (weights at: anIndex)
]
