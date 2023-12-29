"
My instances put events on a shape, when this shapes moves it will be on top of the visualization
"
Class {
	#name : 'RSNodeOnTopWhenPositionChanged',
	#superclass : 'RSInteraction',
	#category : 'Roassal-Interaction-Extra',
	#package : 'Roassal-Interaction',
	#tag : 'Extra'
}

{ #category : 'hooks' }
RSNodeOnTopWhenPositionChanged >> moveToTop: evt [
	| shape |
	shape := evt shape.
	shape ifNil: [ ^ self ].
	shape isInACanvas ifFalse: [ ^ self ].
	shape pushFront.
	(shape withAllChildren flatCollect: #connectedLines) do: #pushFront
]

{ #category : 'hooks' }
RSNodeOnTopWhenPositionChanged >> onShape: aShape [
	aShape
		when: RSPositionChangedEvent
		send: #moveToTop:
		to: self
]
