Extension { #name : #TSGroup }

{ #category : #'*Roassal3' }
TSGroup >> asElement [ 
	^ self asElementOn: nil
]

{ #category : #'*Roassal3' }
TSGroup >> asElementOn: model [
	| el |
	el := RSElement new 
		model: model.
	el trachelShape: self.
	^ el
]
