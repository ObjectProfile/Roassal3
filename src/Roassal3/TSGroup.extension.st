Extension { #name : #TSGroup }

{ #category : #'*Roassal3' }
TSGroup >> @ int [
	self do: [ :e | e @ int ].
]

{ #category : #'*Roassal3' }
TSGroup >> asElement [ 
	^ self asElementOn: nil
]

{ #category : #'*Roassal3' }
TSGroup >> asElementOn: model [
	^ RSComposite new 
		model: model;
		shape: TSComposite new;
		shapes: self.
]

{ #category : #'*Roassal3' }
TSGroup >> edges [
	^ self select: [ :o | o class == RSEdge ]
]

{ #category : #'*Roassal3' }
TSGroup >> elements [
	^ self select: [ :o | o class == RSElement ]
]
