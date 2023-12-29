Extension { #name : 'AthensPathSegment' }

{ #category : '*Roassal-SVG' }
AthensPathSegment >> durationFor: aPoint [
	^ self subclassResponsibility
]

{ #category : '*Roassal-SVG' }
AthensPathSegment >> pointsWithStart: aPoint [
	^ self pointsWithStart: aPoint duration: (self durationFor: aPoint)
]

{ #category : '*Roassal-SVG' }
AthensPathSegment >> pointsWithStart: aPoint duration: duration [
	^ self subclassResponsibility
]
