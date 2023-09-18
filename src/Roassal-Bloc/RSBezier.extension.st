Extension { #name : #RSBezier }

{ #category : #'*Roassal3-Bloc' }
RSBezier >> asBlGeometry [

	^ BlBezierCurveGeometry new
]

{ #category : #'*Roassal3-Bloc' }
RSBezier >> updateBlGeometry: aBlGeometry [

	aBlGeometry controlPoints: self controlPoints
]
