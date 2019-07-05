"
I am an interaction or for the view
"
Class {
	#name : #RSZoomMove,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'delta'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSZoomMove class >> in [
	^ self new in
]

{ #category : #'instance creation' }
RSZoomMove class >> out [
	^ self new out
]

{ #category : #modes }
RSZoomMove >> in [
	delta := 1.5
]

{ #category : #initialization }
RSZoomMove >> initialize [ 
	super initialize.
	self in
]

{ #category : #hooks }
RSZoomMove >> onElement: anElement [
	| scale camera |
	camera := anElement canvas camera.
	scale := camera scale.
	anElement newAnimation 
		easing: TSEasing backOut;
		duration: 200 milliSeconds;
		from: scale;
		to: scale * delta;
		on: anElement canvas camera set: #scale: 
]

{ #category : #modes }
RSZoomMove >> out [
	delta := 0.5
]
