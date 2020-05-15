"
I provide element resizing in all eight directions. 

Resizing handles are displayed after clicking on an associated shape, and are automatically removed when clicked on a canvas or another shape.

!! Assumptions

You must provide this class with aCanvas instance or the initialized element must be already added to the canvas.


"
Class {
	#name : #RSResizable,
	#superclass : #RSInteraction,
	#instVars : [
		'enabled'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #public }
RSResizable >> disable [ 
	enabled := false
]

{ #category : #public }
RSResizable >> disable: aRSMouseLeftDragStart [ 
	self shouldBeImplemented.
]

{ #category : #public }
RSResizable >> enable [
	enabled := true
]

{ #category : #hooks }
RSResizable >> onShape: aShape [
	aShape announcer
		when: RSMouseLeftClick send: #showHandles: to: self;
		when: RSMouseDragStart send: #disable: to: self;
		when: RSMouseDragEnd send: #enable to: self.
	self enable.
]
