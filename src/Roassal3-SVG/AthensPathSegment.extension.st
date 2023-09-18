Extension { #name : #AthensPathSegment }

{ #category : #'*Roassal3-SVG' }
AthensPathSegment >> durationFor: aPoint [
	^ self subclassResponsibility
]

{ #category : #'*Roassal3-SVG' }
AthensPathSegment >> pointsWithStart: aPoint [
	^ self pointsWithStart: aPoint duration: (self durationFor: aPoint)
]

{ #category : #'*Roassal3-SVG' }
AthensPathSegment >> pointsWithStart: aPoint duration: duration [
	^ self subclassResponsibility
]
