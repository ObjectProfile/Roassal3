"
I add key events to the view to move it, zoom it with the key board
"
Class {
	#name : #RSKeyNavigationView,
	#superclass : #RSAbstractControlView,
	#instVars : [
		'steps',
		'speed',
		'animation',
		'speedMult'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #'events-processing' }
RSKeyNavigationView >> expandCollapse: evt [
	evt view morph owner expandBoxHit
]

{ #category : #initialization }
RSKeyNavigationView >> initialize [
	super initialize.
	steps := Set new.
	speed := 1.
		
	
]

{ #category : #hooks }
RSKeyNavigationView >> onElement: aView [
	aView 
		when: TSKeyDown do: [ :evt | self processKeyDown: evt ];
		when: TSKeyUp do: [ :evt | self processKeyUp: evt ].
]

{ #category : #events }
RSKeyNavigationView >> processKeyDown: evt [
	| char rect lastMS |
	char := evt keyCharacter.
	char == Character arrowLeft ifTrue: [ steps add: -1@0 ].
	char == Character arrowRight ifTrue: [ steps add: 1@0 ].
	char == Character arrowUp ifTrue: [ steps add: 0@ -1 ].
	char == Character arrowDown ifTrue: [ steps add: 0@ 1 ].

	speedMult := evt shiftKeyPressed
		ifTrue: [ 4 ] 
		ifFalse: [ 1 ].
	animation ifNotNil: [ ^ self ].
	steps ifEmpty: [ ^ self ].
	rect := self encompassingRectangleFor: evt view.
	speed := (rect width min: rect height) * 0.0005.
	animation := nil.
	lastMS := nil.
	animation := evt canvas newAnimation repeat onStepDo: [ :t |
		| step camera correct position deltaMS current |
		current := animation currentTime.
		lastMS ifNil: [ lastMS := current-1 ].
		deltaMS := current - lastMS.
		lastMS := current.
		step := steps inject: 0@0 into: [:p :s |p+s ].
		camera := evt camera.
		camera translateBy: step / (evt canvas camera scale / (speed * speedMult * deltaMS)).
		position := camera position.
		correct := self correctCameraPosition: evt.
		correct = position 
			ifFalse: [ camera position: correct ].
		evt signalUpdate.
		].
]

{ #category : #events }
RSKeyNavigationView >> processKeyUp: evt [
	| key |
	steps removeAll.
	key := evt keyValue.
	key == 34 "$i" ifTrue: [ ^ self zoomIn: evt ].
	key == 31 "$o" ifTrue: [ ^ self zoomOut: evt ].
	key == 46 "$m" ifTrue: [ ^ self expandCollapse: evt ].
	animation ifNil: [ ^ self ].
	self removeRectanglesFor: evt view.
	animation stop.
	animation := nil.
]

{ #category : #rendering }
RSKeyNavigationView >> renderOn: lb [
	lb
		text: '↑ ↓ → ←' description: 'Arrow keys to move the view';
		text: 'Shift + arrows' description: 'Accelerate the move';
		text: 'M' description: 'Maximize or restore the window';
		text: 'I' description: 'Zoom in';
		text: 'O' description: 'Zoom out'.
]

{ #category : #'events-processing' }
RSKeyNavigationView >> zoomIn: evt [
	self zoomMove: evt delta: 1.5
]

{ #category : #'events-processing' }
RSKeyNavigationView >> zoomMove: evt delta: delta [
	| scale camera newScale correct |
	camera := evt camera.
	scale := camera scale.
	newScale := self scaleFor: delta * scale. 
	evt canvas newAnimation 
		easing: TSEasing backOut;
		duration: 200 milliSeconds;
		from: scale;
		to: newScale;
		on: camera set: #scale:.
	correct := self 
		correctCameraPosition: evt
		scale: newScale.
	correct = camera position ifTrue: [ ^ self ].
	evt canvas newAnimation 
		easing: TSEasing backOut;
		duration: 200 milliSeconds;
		from: camera position;
		to: correct;
		on: camera set: #translateTo:.
]

{ #category : #'events-processing' }
RSKeyNavigationView >> zoomOut: evt [
	self zoomMove: evt delta: 0.5.
	
]

{ #category : #'events-processing' }
RSKeyNavigationView >> zoomToFit: evt [
]
