Extension { #name : 'Array' }

{ #category : '*Roassal-Shapes' }
Array >> asShape [
	^ self asShapeFor: nil
]

{ #category : '*Roassal-Shapes' }
Array >> asShapeFor: model [
	^ RSComposite new
		model: model;
		shapes: self;
		yourself
]
