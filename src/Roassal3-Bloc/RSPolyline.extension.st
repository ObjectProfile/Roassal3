Extension { #name : #RSPolyline }

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlElement [

	^ BlElement new
		  geometry: self asBlGeometry;
		  size: self encompassingRectangle extent;
"		  transformDo: [ :aBuilder | 
			  aBuilder transformation addTransformation:
					  ((BlMatrixTransformation matrix: self matrix asBlMatrix) 
						   origin: BlAffineTransformationCenterOrigin new).
			  aBuilder
				  topLeftOrigin;
				  translateBy: self baseRectangle extent / -2 ];
"		  border: self blBorder;
		  background: self blBackground;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSPolyline >> asBlGeometry [

	^ BlPolylineGeometry vertices: self controlPoints
]
