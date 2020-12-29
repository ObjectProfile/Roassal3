"
I am a trait for BoundingShape and Camera since both of them uses an announcement when the position of both changes
"
Trait {
	#name : #RSTPositionable,
	#category : #'Roassal3-Core'
}

{ #category : #actions }
RSTPositionable >> translateBy: deltaAsPoint [
	"Move a shape by a delta value, expressed as a point"
	self translateTo: self position + deltaAsPoint
	
]

{ #category : #actions }
RSTPositionable >> translateTo: aPoint [
	"Translate a shape to a new position, expressed as a point"
	| oldPosition |
	oldPosition := self position.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self position: aPoint.
	self announce: [RSPositionChangedEvent new 
		shape: self; 
		oldPosition: oldPosition;
		newPosition: aPoint ].

]
