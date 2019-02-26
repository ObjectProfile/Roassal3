"
I am an animation that provides a number interpolating between 0 and 1. and apply it the value to one block
"
Class {
	#name : #TSNumberAnimation,
	#superclass : #TSAbstractAnimation,
	#instVars : [
		'stepAction',
		'duration',
		'easing',
		'scale'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #accessing }
TSNumberAnimation >> duration [
	^ Duration milliSeconds: duration
]

{ #category : #accessing }
TSNumberAnimation >> duration: aDuration [
	duration := aDuration asMilliSeconds
]

{ #category : #accessing }
TSNumberAnimation >> easing [
	^ easing
]

{ #category : #accessing }
TSNumberAnimation >> easing: anInterpolator [
	easing := anInterpolator 
]

{ #category : #accessing }
TSNumberAnimation >> from [
	^ scale range first
]

{ #category : #accessing }
TSNumberAnimation >> from: anObject [
	scale range: { anObject. self to}.
]

{ #category : #'action handling' }
TSNumberAnimation >> on: object set: setSelector [
	self 
		assert: (object class canUnderstand: setSelector) 
		description: 'Invalid input'.
	
	self onStepDo: [ :t |
		object perform: setSelector withArguments: { t }.
		canvas signalUpdate.
	]
	
	
]

{ #category : #'action handling' }
TSNumberAnimation >> onStepDo: aBlock [
	stepAction := aBlock
]

{ #category : #'accessing - computed' }
TSNumberAnimation >> progress [ 
	| progress |
	currentLoop ifNil: [ 
		currentLoop := 1 ].
	startLoopTime 
		ifNil: [ startLoopTime := self currentTime ].
	progress := (self currentTime - startLoopTime)/ self duration asMilliSeconds asFloat.
	progress > 1 ifTrue: [ 
		currentLoop := currentLoop + 1.
		startLoopTime := self currentTime.
		progress := 1.
		self announce: (TSAnimationLoopEvent new animation: self).
		 ].
	
	^ progress
]

{ #category : #initialization }
TSNumberAnimation >> reset [
	super reset.
	self duration: 2 asSeconds.
	easing := TSLinearInterpolator new.
	scale := TSScale linear.
]

{ #category : #accessing }
TSNumberAnimation >> scale [
	^ scale
]

{ #category : #accessing }
TSNumberAnimation >> scale: aScale [
	scale := aScale
]

{ #category : #refresing }
TSNumberAnimation >> step [ 
	| progress value |
	
	progress := self progress.
	"interpolate the progrees"
	progress := easing interpolate: progress.
	"apply progress to the value"
	value := self scale scale: progress.
	
	stepAction value: value.
	
	hasCompleted := currentLoop > loops.
]

{ #category : #accessing }
TSNumberAnimation >> to [
	^ scale range last
]

{ #category : #accessing }
TSNumberAnimation >> to: aValue [
	self scale range: { self from. aValue }
]
