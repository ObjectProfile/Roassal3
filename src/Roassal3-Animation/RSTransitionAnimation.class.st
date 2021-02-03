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

{ #category : #public }
RSTransitionAnimation class >> defaultDuration [
	^ 2 seconds
]

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
	"Key method to set an animation. the first argument receives an object, typically a shape, a border, a line. The second argument is a selector that will be used to set the animated value. The selector must take one argument as parameter. Here is an example:

```
c := RSCanvas new.

b := RSBorder new color: Color blue.
b dashArray: #(5 1 5).
(30 to: 60) do: [ :nb |
	box := RSBox new size: nb.
	ellipse := RSEllipse new width: nb; height: nb + 10.
	box border: b.
	ellipse border: b.
	c add: box; add: ellipse.
	 ].

RSFlowLayout on: c shapes.
c @ RSControlsCanvas.

c newAnimation 
	from: 0;
	to: 40;
	on: b set: #dashOffset:.
c
```

Another example, simpler: 
```
c := RSCanvas new.

b := RSBox new size: 30.
c add: b.

c newAnimation 
	from: 0 @ 0;
	to: 100 @ 100;
	on: b set: #position:.

c
```
	"
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

{ #category : #'action handling' }
RSTransitionAnimation >> onStepDo: aBlockClosure with: anObject [
	self onStepDo: [ :t | aBlockClosure value: t value: anObject ]
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

{ #category : #'accessing - computed' }
RSTransitionAnimation >> progressValue: progress [
	| value |
	"interpolate the progress"
	value := easing interpolate: progress.
	"apply progress to the value"
	^ self scale scale: value.
]

{ #category : #accessing }
RSTransitionAnimation >> ramp: arrayOfAssociations [
	scale := NSScale linear
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
	self duration: self class defaultDuration.
	easing := RSLinearInterpolator new.
	scale := NSScale linear.
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
	| value |
	value := self progressValue: self progress.
	stepAction cull: value.
	self updateHasCompleted
	
	
]

{ #category : #accessing }
RSTransitionAnimation >> stepAction [
	^ stepAction
]

{ #category : #accessing }
RSTransitionAnimation >> to [
	^ scale range last
]

{ #category : #accessing }
RSTransitionAnimation >> to: aValue [
	scale to: aValue.
]
