"
I am a trait for BoundingShape and Camera since both of them uses an announcement when the position of both changes
"
Trait {
	#name : #TPositionable,
	#category : #'Roassal3-Core'
}

{ #category : #actions }
TPositionable >> basicTranslateBy: delta [
	self position: self position + delta
]

{ #category : #actions }
TPositionable >> translateBy: delta [
	self translateTo: self position + delta.
	
]

{ #category : #actions }
TPositionable >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self position: aPoint.
	self announce: [TSPositionChangedEvent new 
		shape: self; 
		oldPosition: oldPosition;
		newPosition: aPoint ].

]
