Extension { #name : #RSAbstractLine }

{ #category : #'*Roassal-Bloc' }
RSAbstractLine >> asBlElement [

	^ BlElement new
		  roassalShape: self;
		  geometry: self asBlGeometry;
		  beOutskirtsCentered;
		  in: [ :e | self updateBlElement: e ];
		  yourself
]

{ #category : #'*Roassal-Bloc' }
RSAbstractLine >> asBlGeometry [

	^ self subclassResponsibility
]

{ #category : #'*Roassal-Bloc' }
RSAbstractLine >> updateBlElement: aBlElement [
	"Update the element. Note: Unlike other shapes, the lines need to update the geometry."

	self updateBlGeometry: aBlElement geometry.

	aBlElement
		size: self encompassingRectangle extent;
		border: self blBorder;
		background: self blPaint
]

{ #category : #'*Roassal-Bloc' }
RSAbstractLine >> updateBlGeometry: aBlGeometry [

	self subclassResponsibility
]
