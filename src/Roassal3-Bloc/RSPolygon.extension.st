Extension { #name : #RSPolygon }

{ #category : #'*Roassal3-Bloc' }
RSPolygon >> asBlElement [
	"We duplicate code from the inherited from super classes but avoid translation. This is related to the fact that RSPolygon>>points: moves received points to center."

	^ BlElement new
		  geometry: self asBlGeometry;
		  size: self baseRectangle extent;
		  transformDo: [ :aBuilder | 
			  aBuilder transformation addTransformation:
					  ((BlMatrixTransformation matrix: self matrix asBlMatrix) 
						   origin: BlAffineTransformationCenterOrigin new) ];
		  border: self blBorder;
		  background: self blPaint;
		  yourself
]

{ #category : #'*Roassal3-Bloc' }
RSPolygon >> asBlGeometry [

	^ BlPolygonGeometry vertices: self points
]
