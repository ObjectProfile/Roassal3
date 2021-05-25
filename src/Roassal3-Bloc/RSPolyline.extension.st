Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry vertices: self controlPoints
]
