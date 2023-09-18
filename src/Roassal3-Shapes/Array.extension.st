Extension { #name : #Array }

{ #category : #'*Roassal3-Shapes' }
Array >> asShape [
	^ self asShapeFor: nil
]

{ #category : #'*Roassal3-Shapes' }
Array >> asShapeFor: model [
	^ RSComposite new
		model: model;
		shapes: self;
		yourself
]
