Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlElement [

	^ self asBlGeometry asElement
		  size: self encompassingRectangle extent;
		  border: self blBorder;
		  background: self blBackground;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry vertices: self controlPoints
]
