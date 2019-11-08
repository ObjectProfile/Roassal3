"
I am an animation that provides a number interpolating between 0 and 1. and apply it the value to one block
"
Class {
	#name : #RSTransitionAnimation,
	#superclass : #RSAbstractAnimation,
	#instVars : [
		'stepAction',
		'duration',
		'easing',
		'scale'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #accessing }
RSTransitionAnimation >> duration [
	^ Duration milliSeconds: duration
]

{ #category : #accessing }
RSTransitionAnimation >> duration: aDuration [
	duration := aDuration asMilliSeconds
]

{ #category : #accessing }
RSTransitionAnimation >> easing [
	^ easing
]

{ #category : #accessing }
RSTransitionAnimation >> easing: anInterpolator [
	easing := anInterpolator 
]

{ #category : #accessing }
RSTransitionAnimation >> from [
	^ scale range first
]

{ #category : #accessing }
RSTransitionAnimation >> from: anObject [
	scale from: anObject
]

{ #category : #initialization }
RSTransitionAnimation >> initialize [
	super initialize.
	self onStepDo: [ :t | ].
	
]

{ #category : #'action handling' }
RSTransitionAnimation >> on: object set: setSelector [
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
RSTransitionAnimation >> onStepDo: aBlock [
	stepAction := aBlock
]

{ #category : #'accessing - computed' }
RSTransitionAnimation >> progress [ 
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
RSTransitionAnimation >> ramp: arrayOfAssociations [
	scale := TSScale linear
		domain: (arrayOfAssociations collect: #key);
		range: (arrayOfAssociations collect: #value)
]

{ #category : #accessing }
RSTransitionAnimation >> range: aTwoArrayOfNumbers [
	scale range: aTwoArrayOfNumbers
]

{ #category : #initialization }
RSTransitionAnimation >> reset [
	super reset.
	self duration: 2 asSeconds.
	easing := TSLinearInterpolator new.
	scale := TSScale linear.
]

{ #category : #accessing }
RSTransitionAnimation >> scale [
	^ scale
]

{ #category : #accessing }
RSTransitionAnimation >> scale: aScale [
	scale := aScale
]

{ #category : #refresing }
RSTransitionAnimation >> step [ 
	| progress value |
	
	progress := self progress.
	"interpolate the progrees"
	progress := easing interpolate: progress.
	"apply progress to the value"
	value := self scale scale: progress.
	
	stepAction value: value.
	hasCompleted ifFalse: [ hasCompleted := currentLoop > loops ].
	
	
]

{ #category : #accessing }
RSTransitionAnimation >> to [
	^ scale range last
]

{ #category : #accessing }
RSTransitionAnimation >> to: aValue [
	scale to: aValue.
]
