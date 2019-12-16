Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Scripting' }
RSGroup >> edges [
	^ self select: [ :o | o class == RSEdge ]
]

{ #category : #'*Roassal3-Scripting' }
RSGroup >> elements [
	^ self select: [ :o | o class == RSElement ]
]
