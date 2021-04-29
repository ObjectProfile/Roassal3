Extension { #name : #RSBoundingShape }

{ #category : #'*Roassal3-Bloc' }
RSBoundingShape >> asBlElement [

	^ BlElement new
		  geometry: self asBlGeometry;
		  size: self baseRectangle extent;
		  transformDo: [ :aBuilder | 
			  aBuilder transformation addTransformation:
					  ((BlMatrixTransformation matrix: self matrix asBlMatrix) 
						   origin: BlAffineTransformationCenterOrigin new).
			  aBuilder
					translateBy: self baseRectangle extent / -2 ];
		  border: self blBorder;
		  background: self blBackground;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSBoundingShape >> asBlGeometry [

	^ self subclassResponsibility
]
