Extension { #name : #RSBitmap }

{ #category : #'*Roassal-Bloc' }
RSBitmap >> asBlGeometry [

	^ BlRectangleGeometry new
]

{ #category : #'*Roassal-Bloc' }
RSBitmap >> blPaint [

	^ BlImageBackground image: form
]
