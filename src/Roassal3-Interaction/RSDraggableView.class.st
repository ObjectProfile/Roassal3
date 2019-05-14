"
I am an interaction that makes a view draggable using the mouse.

For example:
-=-=-=-=-=-=-=-=-=
	| v |
	v := RTView new.
	v @ RTDraggableView.
	RTCPDiverging new viewOn: v.
	^ v
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSDraggableView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'mouse'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSDraggableView class >> all [
	^ self new
]

{ #category : #'instance creation' }
RSDraggableView class >> left [
	^ self new left
]

{ #category : #'instance creation' }
RSDraggableView class >> middle [
	^ self new middle
]

{ #category : #'instance creation' }
RSDraggableView class >> right [
	^ self new right
]

{ #category : #'public - configuration' }
RSDraggableView >> all [
	"Any mouse button can be used to drag and drop the view"
	mouse := TSMouseDragStart.
]

{ #category : #initialization }
RSDraggableView >> initialize [
	super initialize.
	
	"Any button can be used to drag and drop"
	self all.
]

{ #category : #'public - configuration' }
RSDraggableView >> left [
	"Only the left mouse button can be used to drag and drop the view
	For example:
	
	| v |
	v := RTView new.
	v @ RTDraggableView new left.
	RTCPDiverging new viewOn: v.
	^ v
	"
	mouse := TSMouseLeftDragStart
]

{ #category : #'public - configuration' }
RSDraggableView >> middle [
	"Only the middle mouse button can be used to drag and drop the view
	For example:
	
	| v |
	v := RTView new.
	v @ RTDraggableView new middle.
	RTCPDiverging new viewOn: v.
	^ v
	"
	mouse := TSMouseMiddleDragStart
]

{ #category : #accessing }
RSDraggableView >> mouse [
	"Return the class describing the mouse event for which the view can be dragged"
	^ mouse
]

{ #category : #hooks }
RSDraggableView >> onElement: aView [
	"Configure the view provided as argument with call to properly handles the mouse interaction"
	"also add key events for navigation"
	| move lastStep camera |
	move := false.
	lastStep := nil.
	camera := aView camera.
	aView when: self mouse do: [ move := true].
	aView when: TSMouseDragging do: [ :e |
		move ifTrue: [ 
			lastStep := e step negated / aView camera scale.
			camera translateBy: lastStep.
			e signalUpdate ]
		].
	aView when: TSMouseDragEnd do: [ 
		move := false.
		(lastStep isNotNil and: [ lastStep x abs > 2 or: [lastStep y abs > 2]  ]) ifTrue: [ 
			aView animation 
				easing: TSEasing cubicOut;
				duration: 200 milliSeconds;
				from: camera position;
				to: camera position + (lastStep * 3);
				on: camera set: #translateTo:
		]
	].
	
]

{ #category : #'public - configuration' }
RSDraggableView >> right [
	"Only the right mouse button can be used to drag and drop the view
	For example:
	
	| v |
	v := RTView new.
	v @ RTDraggableView new right.
	RTCPDiverging new viewOn: v.
	^ v
	"
	mouse := TSMouseRightDragStart.
]
