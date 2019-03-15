"
I am an animation that provides a number interpolating between 0 and 1. and apply it the value to one block
"
Class {
	#name : #TSTransitionAnimation,
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
TSTransitionAnimation >> duration [
	^ Duration milliSeconds: duration
]

{ #category : #accessing }
TSTransitionAnimation >> duration: aDuration [
	duration := aDuration asMilliSeconds
]

{ #category : #accessing }
TSTransitionAnimation >> easing [
	^ easing
]

{ #category : #accessing }
TSTransitionAnimation >> easing: anInterpolator [
	easing := anInterpolator 
]

{ #category : #accessing }
TSTransitionAnimation >> from [
	^ scale range first
]

{ #category : #accessing }
TSTransitionAnimation >> from: anObject [
	scale from: anObject
]

{ #category : #initialization }
TSTransitionAnimation >> initialize [
	super initialize.
	self onStepDo: [ :t | ].
	
]

{ #category : #'action handling' }
TSTransitionAnimation >> on: object set: setSelector [
	| sel |
	sel := setSelector asSymbol.
	self 
		assert: (object class canUnderstand: sel) 
		description: 'Invalid input'.
	
	self onStepDo: [ :t |
		object perform: sel withArguments: { t }.
		canvas signalUpdate.
	]
	
	
]

{ #category : #'action handling' }
TSTransitionAnimation >> onStepDo: aBlock [
	stepAction := aBlock
]

{ #category : #'accessing - computed' }
TSTransitionAnimation >> progress [ 
	| progress |
	self startStep.
	progress := (self currentTime - pauseTime - startLoopTime)/ duration asFloat.
	progress > 1 ifTrue: [ 
		self loopDone.
		progress := 1.
		 ].
	
	^ progress
]

{ #category : #accessing }
TSTransitionAnimation >> ramp: arrayOfAssociations [
	"canvas animation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)}."
	scale := TSScale linear
		domain: (arrayOfAssociations collect: #key);
		range: (arrayOfAssociations collect: #value)
]

{ #category : #initialization }
TSTransitionAnimation >> reset [
	super reset.
	self duration: 2 asSeconds.
	easing := TSLinearInterpolator new.
	scale := TSScale linear.
]

{ #category : #accessing }
TSTransitionAnimation >> scale [
	^ scale
]

{ #category : #accessing }
TSTransitionAnimation >> scale: aScale [
	scale := aScale
]

{ #category : #refresing }
TSTransitionAnimation >> step [ 
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
TSTransitionAnimation >> to [
	^ scale range last
]

{ #category : #accessing }
TSTransitionAnimation >> to: aValue [
	scale to: aValue.
]
