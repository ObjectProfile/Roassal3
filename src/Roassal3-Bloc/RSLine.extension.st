Extension { #name : #RSLine }

{ #category : #'*Roassal3-Bloc' }
RSLine >> asBlGeometry [
	
	^ BlLineGeometry new
]

{ #category : #'*Roassal3-Bloc' }
RSLine >> updateBlGeometry: aBlGeometry [

	aBlGeometry from: self startPoint to: self endPoint
]
