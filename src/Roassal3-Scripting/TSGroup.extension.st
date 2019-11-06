Extension { #name : #TSGroup }

{ #category : #'*Roassal3-Scripting' }
TSGroup >> asShape [
	^ self asShapeOn: nil
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> asShapeOn: model [
	^ TSComposite new 
		model: model;
		shapes: self
		yourself
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> edges [
	^ self select: [ :o | o class == RSEdge ]
]

{ #category : #'*Roassal3-Scripting' }
TSGroup >> elements [
	^ self select: [ :o | o class == RSElement ]
]
