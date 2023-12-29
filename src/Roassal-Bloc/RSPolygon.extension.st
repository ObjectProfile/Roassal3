Extension { #name : #RSPolygon }

{ #category : #'*Roassal-Bloc' }
RSPolygon >> asBlGeometry [

	^ BlPolygonGeometry vertices: self points
]

{ #category : #'*Roassal-Bloc' }
RSPolygon >> updateBlElement: aShapeElement [
	"We duplicate a lot of code from the inherited from super classes but avoid translation. This is related to the fact that RSPolygon>>points: moves received points to center."

	aShapeElement
		size: self baseRectangle extent;
		transformation: self blTransformation;
		border: self blBorder;
		background: self blPaint
]
