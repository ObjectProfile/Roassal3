Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Shapes' }
RSGroup >> asShapeFor: model [
	^ RSComposite new 
		model: model;
		shapes: self
		yourself
]
