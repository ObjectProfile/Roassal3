Class {
	#name : #TSPointInterpolator,
	#superclass : #TSAbstractInterpolator,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSPointInterpolator >> interpolate: aPoint [
	^ (start x * (1 - aPoint x)) + (stop x * aPoint x) @ 
		(start y * (1 - aPoint y)) + (stop y * aPoint y) 

]
