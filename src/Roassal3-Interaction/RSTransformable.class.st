"
I provide element resizing in all eight directions. 

Resizing handles are displayed after clicking on an associated shape, and are automatically removed when clicked on a canvas or another shape.

!! Assumptions

You must provide this class with aCanvas instance or the initialized element must be already added to the canvas.


"
Class {
	#name : #RSTransformable,
	#superclass : #RSInteraction,
	#instVars : [
		'enabled'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSTransformable >> createHandlesFor: shape [
	| controls circle rect circles |
	controls := RSGroup new.
	rect := shape encompassingRectangle.
	controls add: (RSBox new
		noPaint;
		border: (RSBorder new
			color: Color gray);
		fromRectangle: rect;
		yourself).
	circle := RSEllipse new
		size: 10;
		color: Color white;
		border: (RSBorder new width: 5; color: Color gray).
	circles := #(topLeft bottomLeft topRight bottomRight) collect: [ :sel |
		circle copy
			position: (rect perform: sel) ].
	
	
	^ controls.
		
	
	
]

{ #category : #hooks }
RSTransformable >> disable [
	enabled := false
]

{ #category : #public }
RSTransformable >> enable [
	enabled := true
]

{ #category : #hooks }
RSTransformable >> onShape: aShape [
	aShape isNode ifFalse: [ ^ self ].
	aShape announcer
		when: RSMouseLeftClick send: #showHandles: to: self;
		when: RSMouseDragStart send: #disable to: self;
		when: RSMouseDragEnd send: #enable to: self.
	self enable.
]

{ #category : #hooks }
RSTransformable >> showHandles: evt [ 
	
	| parent shape controls |
	shape := evt shape.
	parent := shape parent.
	controls := self createHandlesFor: shape.
	parent addAll: controls.
	evt signalUpdate.
	
	
	
	
		
		
		
	
	
]
