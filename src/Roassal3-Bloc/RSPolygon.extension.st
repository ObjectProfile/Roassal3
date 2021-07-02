Extension { #name : #RSPolygon }

{ #category : #'*Roassal3-Bloc' }
RSPolygon >> asBlGeometry [

	^ BlPolygonGeometry vertices: self points
]

{ #category : #'*Roassal3-Bloc' }
RSPolygon >> updateBlElement: aBlElement [
	"We duplicate a lot of code from the inherited from super classes but avoid translation. This is related to the fact that RSPolygon>>points: moves received points to center."

	aBlElement
		size: self baseRectangle extent;
		transformDo: [ :aBuilder | 
			aBuilder transformation addTransformation:
					((BlMatrixTransformation matrix: self matrix asBlMatrix) origin:
							 BlAffineTransformationCenterOrigin new) ];
		border: self blBorder;
		background: self blPaint
]
