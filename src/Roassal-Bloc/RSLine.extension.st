Extension { #name : #RSLine }

{ #category : #'*Roassal-Bloc' }
RSLine >> asBlGeometry [
	
	^ BlLineGeometry new
]

{ #category : #'*Roassal-Bloc' }
RSLine >> updateBlGeometry: aBlGeometry [

	aBlGeometry from: self startPoint to: self endPoint
]
