Extension { #name : #RSUserInputEvent }

{ #category : #'*Roassal3-Spec-Gtk' }
RSUserInputEvent class >> fromGtkEvent: aUserInputEvent [
	| commandKeyPressed controlKeyPressed shiftKeyPressed optionKeyPressed |
	aUserInputEvent isEventMotion
		ifTrue: [commandKeyPressed :=  aUserInputEvent hasMetaModifier.
			controlKeyPressed := aUserInputEvent hasControlModifier.
			shiftKeyPressed := aUserInputEvent hasShiftModifier.
			optionKeyPressed := aUserInputEvent hasAltModifier]
		ifFalse: [ commandKeyPressed :=  false.
			controlKeyPressed := false.
			shiftKeyPressed := false.
			optionKeyPressed := false ].
	^ self new
		commandKeyPressed: commandKeyPressed;
		controlKeyPressed: controlKeyPressed;
		shiftKeyPressed: shiftKeyPressed;
		optionKeyPressed: optionKeyPressed;
		yourself
]
