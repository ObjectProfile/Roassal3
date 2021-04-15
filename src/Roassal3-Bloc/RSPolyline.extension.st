Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlElement [

	^ BlElement new
		  geometry: self asBlGeometry;
		  size: self encompassingRectangle extent;
		  border: self blBorder;
		  background: self blBackground;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry vertices: self controlPoints
]
