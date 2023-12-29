Extension { #name : #RSPolyline }

{ #category : #'*Roassal-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry new
]

{ #category : #'*Roassal-Bloc' }
RSPolyline >> updateBlGeometry: aBlGeometry [

	aBlGeometry vertices: self controlPoints
]
