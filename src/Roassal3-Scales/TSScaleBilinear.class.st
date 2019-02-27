"
I represent a bilinear range for 2 limits, start and end
"
Class {
	#name : #TSScaleBilinear,
	#superclass : #TSScale,
	#instVars : [
		'i',
		'u'
	],
	#category : #'Roassal3-Scales-Core'
}

{ #category : #hooks }
TSScaleBilinear >> rescale [
	u := uninterpolate uninterpolate: domain first and: domain second.
	i := interpolate interpolate: range first and: range second.
]

{ #category : #transformation }
TSScaleBilinear >> scale: x [
	^ i interpolate: (u uninterpolate: x)
]
