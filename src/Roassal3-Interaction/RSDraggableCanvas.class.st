"
I set the drag event for view, I use a basic bars to do that.

Use example:
```Smalltalk
c := RSCanvas new.
c add: (RSBox new size: 30).
c @ RSDraggableCanvas
```
"
Class {
	#name : #RSDraggableCanvas,
	#superclass : #RSAbstractControlCanvas,
	#instVars : [
		'mouseEvent',
		'isMoving',
		'lastStep'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSDraggableCanvas class >> left [
	^ self new left
]

{ #category : #accessing }
RSDraggableCanvas class >> middle [
	^ self new middle
]

{ #category : #accessing }
RSDraggableCanvas class >> right [
	^ self new right
]

{ #category : #mouse }
RSDraggableCanvas >> all [
	"Any mouse button can be used to drag and drop the view"
	mouseEvent := RSMouseDragStart.
]

{ #category : #computing }
RSDraggableCanvas >> checkCamera: aCanvas [
	| camera p correct |
	camera := aCanvas camera.
	p := camera position.
	correct := self correctCameraPosition: aCanvas.
	correct = p ifTrue: [ ^ self ].
	
	self removeRectanglesFor: aCanvas.
	
	aCanvas newAnimation
		easing: RSEasing cubicIn;
		duration: 200 milliSeconds;
		from: p;
		to: correct;
		on: camera set: #translateTo:.
]

{ #category : #initialize }
RSDraggableCanvas >> initialize [
	super initialize.
	self all.
	isMoving := false.
]

{ #category : #mouse }
RSDraggableCanvas >> left [
	mouseEvent := RSMouseLeftDragStart
]

{ #category : #mouse }
RSDraggableCanvas >> middle [
	mouseEvent := RSMouseMiddleDragStart
]

{ #category : #events }
RSDraggableCanvas >> mouseEnd: evt [
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
		easing: RSEasing cubicOut;
		duration: 200 milliSeconds;
		from: camera position; to: camera position + (delta / p);
		on: camera set: #translateTo:;
		when: RSAnimationEndEvent do: [ self checkCamera: aCanvas ].
		

]

{ #category : #mouse }
RSDraggableCanvas >> mouseEvent [
	^ mouseEvent
]

{ #category : #events }
RSDraggableCanvas >> mouseMove: evt [
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
RSDraggableCanvas >> mouseStart: evt [
	isMoving := true.
	lastStep := nil.
]

{ #category : #hooks }
RSDraggableCanvas >> onShape: aCanvas [
	aCanvas 
		when: self mouseEvent do: [ :evt | self mouseStart: evt ];
		when: RSMouseDragging do: [ :evt | self mouseMove: evt ];
		when: RSMouseDragEnd do: [ :evt | self mouseEnd: evt ].
]

{ #category : #rendering }
RSDraggableCanvas >> renderLegendOn: lb [
	lb text: 'Mouse click' description: 'To move the view''s camera'
]

{ #category : #mouse }
RSDraggableCanvas >> right [
	mouseEvent := RSMouseRightDragStart.
]
