"
I set the drag event for view, I use a basic bars to do that
"
Class {
	#name : #TSDraggableCanvas,
	#superclass : #TSAbstractControlCanvas,
	#instVars : [
		'mouseEvent',
		'isMoving',
		'lastStep'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
TSDraggableCanvas class >> left [
	^ self new left
]

{ #category : #accessing }
TSDraggableCanvas class >> middle [
	^ self new middle
]

{ #category : #accessing }
TSDraggableCanvas class >> right [
	^ self new right
]

{ #category : #mouse }
TSDraggableCanvas >> all [
	"Any mouse button can be used to drag and drop the view"
	mouseEvent := TSMouseDragStart.
]

{ #category : #computing }
TSDraggableCanvas >> checkCamera: aCanvas [
	| camera p correct |
	camera := aCanvas camera.
	p := camera position.
	correct := self correctCameraPosition: aCanvas.
	correct = p ifTrue: [ ^ self ].
	
	self removeRectanglesFor: aCanvas.
	
	aCanvas newAnimation
		easing: TSEasing cubicIn;
		duration: 200 milliSeconds;
		from: p;
		to: correct;
		on: camera set: #translateTo:.
]

{ #category : #initialize }
TSDraggableCanvas >> initialize [
	super initialize.
	self all.
	isMoving := false.
]

{ #category : #mouse }
TSDraggableCanvas >> left [
	mouseEvent := TSMouseLeftDragStart
]

{ #category : #mouse }
TSDraggableCanvas >> middle [
	mouseEvent := TSMouseMiddleDragStart
]

{ #category : #events }
TSDraggableCanvas >> mouseEnd: evt [
	| threshold aCanvas camera delta p correct |
	isMoving := false.
	lastStep ifNil: [ ^ self ].
	aCanvas := evt canvas.
	camera := evt camera.
	threshold := 4.
	(lastStep dist: 0@0) < threshold
		ifTrue: [ ^ self checkCamera: aCanvas ].
		
	delta := lastStep * 2.5.
	camera translateBy: delta.
	correct := self correctCameraPosition: evt.
	camera translateBy: delta negated.
			
	p := (correct - camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.
	
	aCanvas newAnimation 
		easing: TSEasing cubicOut;
		duration: 200 milliSeconds;
		from: camera position; to: camera position + (delta / p);
		on: camera set: #translateTo:;
		when: TSAnimationEndEvent do: [ self checkCamera: aCanvas ].
		

]

{ #category : #mouse }
TSDraggableCanvas >> mouseEvent [
	^ mouseEvent
]

{ #category : #events }
TSDraggableCanvas >> mouseMove: evt [
	| camera p correct |
	isMoving ifFalse: [ ^ self ].
	camera := evt camera.
	lastStep := evt step negated / camera scale.
	correct  := self correctCameraPosition: evt.
	p := (correct - camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.
	camera translateBy: lastStep/ p.
	evt signalUpdate.
]

{ #category : #events }
TSDraggableCanvas >> mouseStart: evt [
	isMoving := true.
	lastStep := nil.
]

{ #category : #hooks }
TSDraggableCanvas >> onShape: aCanvas [
	aCanvas 
		when: self mouseEvent do: [ :evt | self mouseStart: evt ];
		when: TSMouseDragging do: [ :evt | self mouseMove: evt ];
		when: TSMouseDragEnd do: [ :evt | self mouseEnd: evt ].
]

{ #category : #rendering }
TSDraggableCanvas >> renderOn: lb [
	lb text: 'Mouse click' description: 'To move the view''s camera'
]

{ #category : #mouse }
TSDraggableCanvas >> right [
	mouseEvent := TSMouseRightDragStart.
]
