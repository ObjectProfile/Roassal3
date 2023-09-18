Extension { #name : #RSBezier }

{ #category : #'*Roassal-Bloc' }
RSBezier >> asBlGeometry [

	^ BlBezierCurveGeometry new
]

{ #category : #'*Roassal-Bloc' }
RSBezier >> updateBlGeometry: aBlGeometry [

	aBlGeometry controlPoints: self controlPoints
]
