Extension { #name : #BlMouseEvent }

{ #category : #'*Roassal3-Bloc' }
BlMouseEvent >> roassalFill: aRSMouseMove [ 
	
	self flag: #todo.
"	aRSMouseMove 
		commandKeyPressed: aUserInputEvent commandKeyPressed;
		controlKeyPressed: aUserInputEvent controlKeyPressed;
		shiftKeyPressed: aUserInputEvent shiftPressed;
		optionKeyPressed: aUserInputEvent optionKeyPressed.
"
]
