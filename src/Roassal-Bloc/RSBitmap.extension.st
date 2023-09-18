Extension { #name : #RSBitmap }

{ #category : #'*Roassal3-Bloc' }
RSBitmap >> asBlGeometry [

	^ BlRectangleGeometry new
]

{ #category : #'*Roassal3-Bloc' }
RSBitmap >> blPaint [

	^ BlImageBackground image: form
]
