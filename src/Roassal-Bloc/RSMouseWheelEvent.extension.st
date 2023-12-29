Extension { #name : #RSMouseWheelEvent }

{ #category : #'*Roassal-Bloc' }
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
