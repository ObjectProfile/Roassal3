Extension { #name : #TSGroup }

{ #category : #'*Roassal3-Scripting' }
TSGroup >> asElement [ 
	^ self asElementOn: nil
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> asElementOn: model [
	^ RSComposite new 
		model: model;
		shape: TSComposite new;
		shapes: self.
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> edges [
	^ self select: [ :o | o class == RSEdge ]
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> elements [
	^ self select: [ :o | o class == RSElement ]
]
