Extension { #name : #RSBoundingShape }

{ #category : #'*Roassal3-Bloc' }
RSBoundingShape >> asBlElement [

	^ BlElement new
		  roassalShape: self;
		  geometry: self asBlGeometry;
		  in: [ :e | self updateBlElement: e ];
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSBoundingShape >> asBlGeometry [

	^ self subclassResponsibility
]

{ #category : #'*Roassal3-Bloc' }
RSBoundingShape >> updateBlElement: aBlElement [

"	aBlElement transformation: aBlElement transformation asElementTransformation.
"	aBlElement
		  size: self baseRectangle extent;
		  transformDo: [ :aBuilder | 
			  aBuilder transformation addTransformation:
					  ((BlMatrixTransformation matrix: self matrix asBlMatrix) 
						   origin: BlAffineTransformationCenterOrigin new).
			  aBuilder translateBy: self baseRectangle extent / -2 ];
		  border: self blBorder;
		  background: self blPaint
]
