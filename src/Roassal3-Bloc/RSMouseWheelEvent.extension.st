Extension { #name : #RSMouseWheelEvent }

{ #category : #'*Roassal3-Bloc' }
RSMouseWheelEvent class >> newFromBlEvent: aBlEvent canvas: roassalCanvas [
	| instance direction |
	instance := super 
		newFromBlEvent: aBlEvent
		canvas: roassalCanvas.
	direction := aBlEvent vector y > 0
		ifTrue: [ Character arrowUp ]
		ifFalse: [ Character arrowDown ].
	instance direction: direction.
	^ instance
]
