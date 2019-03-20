Extension { #name : #TSGroup }

{ #category : #'*Roassal3' }
TSGroup >> asElement [ 
	^ self asElementOn: nil
]

{ #category : #'*Roassal3' }
TSGroup >> asElementOn: model [
	^ RSElement new 
		model: model;
		trachelShape: (TSComposite new 
			shapes: self).
]
