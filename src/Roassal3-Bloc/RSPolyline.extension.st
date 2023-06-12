Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry new
]

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> updateBlGeometry: aBlGeometry [

	aBlGeometry vertices: self controlPoints
]
