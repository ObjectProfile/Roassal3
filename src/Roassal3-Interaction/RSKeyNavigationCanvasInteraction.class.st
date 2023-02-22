"
I add key events to the view to move it, zoom it with the key board.

I interact with:
- `RSCanvasController`
- `RSControlConfiguration`

### Keys
- Arrows: small move in the desired direction
- Arrows + Shift: large move in the desired direction
- M: to expand or collapse the current window
- O: to zoom out
- I: to zoom in

"
Class {
	#name : #RSKeyNavigationCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'steps',
		'speed',
		'animation',
		'speedMult'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #examples }
RSKeyNavigationCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ self.
	canvas zoomToFit.
	canvas open
]

{ #category : #'events-processing' }
RSKeyNavigationCanvasInteraction >> expandCollapse: evt [
	evt canvas morph window expandBoxHit
]

{ #category : #initialization }
RSKeyNavigationCanvasInteraction >> initialize [
	super initialize.
	steps := Set new.
	speed := 1
]

{ #category : #hooks }
RSKeyNavigationCanvasInteraction >> onShape: aCanvas [
	aCanvas
		when: RSKeyDown send: #processKeyDown: to: self;
		when: RSKeyUp send: #processKeyUp: to: self
]

{ #category : #events }
RSKeyNavigationCanvasInteraction >> processKeyDown: evt [
	| keyName |
	keyName := evt keyName.
	keyName = #I ifTrue: [ ^ self zoomIn: evt canvas ].
	keyName = #O ifTrue: [ ^ self zoomOut: evt canvas ].
	"direcctions has changed to handle new coordinate system"
	self configuration hasHorizontalScrolling ifTrue: [ 
		keyName = #LEFT ifTrue: [ steps add: 1@0 ].
		keyName = #RIGHT ifTrue: [ steps add: -1@0 ].
	].
	self configuration hasVerticalScrolling ifTrue: [ 
		keyName = #UP ifTrue: [ steps add: 0@ 1 ].
		keyName = #DOWN ifTrue: [ steps add: 0@ -1 ].
	].
	
	speedMult := evt shiftKeyPressed
		ifTrue: [ 4 ] 
		ifFalse: [ 1 ].
	animation ifNotNil: [ ^ self ].
	steps ifEmpty: [ ^ self ].
	self processStepsOn: evt canvas
]

{ #category : #events }
RSKeyNavigationCanvasInteraction >> processKeyUp: evt [
	| keyName |
	steps removeAll.
	keyName := evt keyName.
	keyName = #M ifTrue: [ ^ self expandCollapse: evt ].
	animation ifNil: [ ^ self ].
	self removeRectanglesFor: evt canvas.
	animation stop.
	animation := nil
]

{ #category : #events }
RSKeyNavigationCanvasInteraction >> processStepsOn: aCanvas [

	| rect lastMS |
	rect := self encompassingRectangleFor: aCanvas.
	speed := (rect width min: rect height) * 0.0005.
	animation := nil.
	lastMS := nil.
	animation := aCanvas newAnimation repeat onStepDo: [ :t |
		| step camera correct position deltaMS current |
		current := animation currentTime.
		lastMS ifNil: [ lastMS := current-1 ].
		deltaMS := (current - lastMS) max: 1.
		lastMS := current.
		step := steps inject: 0@0 into: [:p :s |p+s ].
		camera := aCanvas camera.
		camera translateBy: step / (aCanvas camera scale / (speed * speedMult * deltaMS)).
		position := camera position.
		correct := self correctCamera: camera.
		correct = position 
			ifFalse: [ camera position: correct ].
		aCanvas signalUpdate.
		].
]

{ #category : #rendering }
RSKeyNavigationCanvasInteraction >> renderLegendOn: lb [
	lb
		text: '↑ ↓ → ←' description: 'Arrow keys to move the view';
		text: 'Shift + arrows' description: 'Accelerate the move';
		text: 'M' description: 'Maximize or restore the window';
		text: 'I' description: 'Zoom in';
		text: 'O' description: 'Zoom out'
]

{ #category : #'events-processing' }
RSKeyNavigationCanvasInteraction >> zoomIn: aCanvas [
	self zoomMove: aCanvas delta: 1.5
]

{ #category : #events }
RSKeyNavigationCanvasInteraction >> zoomMove: aCanvas delta: delta [
	RSZoomableCanvasInteraction 
		zoomMove: aCanvas 
		newScale: (self scaleFor: aCanvas camera scale * delta)
]

{ #category : #'events-processing' }
RSKeyNavigationCanvasInteraction >> zoomOut: aCanvas [
	self zoomMove: aCanvas delta: 0.5
]
