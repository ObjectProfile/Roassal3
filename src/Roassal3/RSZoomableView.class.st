"
I am interaction which allows view to be zoomed with a mouce wheel. While zomming mouce cursor stays on the same spot in the canvas
"
Class {
	#name : #RSZoomableView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'minZoom',
		'maxZoom'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSZoomableView class >> min: aMin max: aMax [
	^ self new
		minZoom: aMin;
		maxZoom: aMax;
		yourself
]

{ #category : #accessing }
RSZoomableView >> maxZoom [
	^ maxZoom ifNil: [ 10 ]
]

{ #category : #accessing }
RSZoomableView >> maxZoom: aFloat [
	maxZoom := aFloat
]

{ #category : #accessing }
RSZoomableView >> minZoom [
	^ minZoom ifNil: [ 0.1 ]
]

{ #category : #accessing }
RSZoomableView >> minZoom: aFloat [
	minZoom := aFloat
]

{ #category : #hooks }
RSZoomableView >> onElement: aView [
	aView 
		when: TSMouseWheelEvent		
		do: [ :e | self processEvent: e ]
]

{ #category : #hooks }
RSZoomableView >> processEvent: evt [
	| scale dist |
	dist := evt position - evt canvas camera position.
	scale := evt canvas camera scale.
	
	evt isUp ifTrue: [  
		scale * 1.25 <= self maxZoom ifTrue: [ 
			scale := scale * 1.25.
			dist := dist * 0.2 ]
		ifFalse: [ ^ self ].
		].
	evt isDown ifTrue:  [
		scale * 0.8 >= self minZoom ifTrue: [ 
			scale := scale * 0.8.
			dist := dist * -0.25 ]
		ifFalse: [ ^ self ]
	].
	evt canvas camera
		scale: scale;
		translateBy: dist.
	evt signalUpdate
]
