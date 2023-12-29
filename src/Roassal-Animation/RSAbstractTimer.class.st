"
Users can set the timer of the canvas this will affect the animations process, by changing the speed of all of them in a canvas
"
Class {
	#name : 'RSAbstractTimer',
	#superclass : 'RSObject',
	#category : 'Roassal-Animation-Core',
	#package : 'Roassal-Animation',
	#tag : 'Core'
}

{ #category : 'examples' }
RSAbstractTimer class >> example [
	| circle c animation timer |
	circle := RSCircle new.
	c := RSCanvas new.
	c add: circle.
	animation := RSTransitionAnimation new
		repeat;
		duration: 5 seconds;
		from: 0;
		to: 100;
		onStepDo: [ :numberBetweenZeroAnd100 |
			circle radius: numberBetweenZeroAnd100; signalUpdate ].
	c addAnimation: animation.
	timer := RSVariableTimer new.
	c timer: timer.
	"I can control the time :V"
	[ 5 timesRepeat: [
		timer addTime: 500 milliSeconds.
		(Delay forSeconds: 1) wait
		] ] fork.
	^ c open
]

{ #category : 'public' }
RSAbstractTimer >> currentTime [
	^ self subclassResponsibility
]
