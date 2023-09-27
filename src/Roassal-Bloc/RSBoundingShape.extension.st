Extension { #name : #RSBoundingShape }

{ #category : #'*Roassal-Bloc' }
RSBoundingShape >> asBlElement [

	^ BlElement new
		  roassalShape: self;
		  geometry: self asBlGeometry;
		  in: [ :e | self updateBlElement: e ];
		  yourself
]

{ #category : #'*Roassal-Bloc' }
RSBoundingShape >> asBlGeometry [

	^ self subclassResponsibility
]

{ #category : #'*Roassal-Bloc' }
RSBoundingShape >> blTransformation [

	| anAffineTransformation |
	anAffineTransformation := BlAffineCompositeTransformation new
		addTransformation: (BlMatrixTransformation matrix: self matrix asBlMatrix);
		addTransformation: (BlTranslationTransformation translation: (self baseRectangle extent / -2) asTranslate3D);
		yourself.

	^ BlElementLocalTransformation newWith: anAffineTransformation
]

{ #category : #'*Roassal-Bloc' }
RSBoundingShape >> updateBlElement: aShapeElement [

	aShapeElement
		size: self baseRectangle extent;
		border: self blBorder;
		background: self blPaint;
		transformation: self blTransformation
]
