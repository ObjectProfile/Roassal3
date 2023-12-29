"
I am the abstract class that defines animations for Roassal
"
Class {
	#name : 'RSAbstractAnimation',
	#superclass : 'RSObject',
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'isRunning',
		'hasCompleted',
		'startTime',
		'endTime',
		'currentLoop',
		'startLoopTime',
		'loops',
		'delay',
		'isPaused',
		'startPauseTime',
		'endPauseTime',
		'pauseTime',
		'canvas',
		'firstStep'
	],
	#category : 'Roassal-Animation-Core',
	#package : 'Roassal-Animation',
	#tag : 'Core'
}

{ #category : 'accessing - defaults' }
RSAbstractAnimation class >> defaultDuration [
	^ self subclassResponsibility
]

{ #category : 'examples' }
RSAbstractAnimation class >> exampleSequentialAnimation [
	| circle c animation a1 a2 |
	circle := RSCircle new.
	c := RSCanvas new.
	c add: circle.
	a1 := RSTransitionAnimation new
		duration: 5 seconds;
		from: 0;
		to: 100;
		onStepDo: [ :t |
			circle radius: t; signalUpdate.
			 ].
	a2 := RSTransitionAnimation new
		duration: 2 seconds;
		from: 100;
		to: 0;
		onStepDo: [ :t |
			circle radius: t; signalUpdate.
		].
	animation := RSSequentialAnimation new
		repeat;
		add: a1;
		add: a2;
		yourself.
	c addAnimation: animation.
	"c newAnimation"
	^ c open
]

{ #category : 'examples' }
RSAbstractAnimation class >> exampleTransition [
	| circle c animation |
	circle := RSCircle new.
	c := RSCanvas new.
	c add: circle.
	animation := RSTransitionAnimation new
		repeat;
		duration: 5 seconds;
		from: 0;
		to: 100;
		onStepDo: [ :numberBetweenZeroAnd100 |
			circle radius: numberBetweenZeroAnd100; signalUpdate.
			 ].
	c addAnimation: animation.
	"c newAnimation"
	^ c open
]

{ #category : 'examples' }
RSAbstractAnimation class >> exampleTransitionColor [
	| circle c animation |
	circle := RSCircle new radius: 40.
	c := RSCanvas new.
	c add: circle.
	animation := RSTransitionAnimation new
		repeat;
		duration: 5 seconds;
		from: Color red;
		to: Color blue;
		onStepDo: [ :colorRedBlue |
			circle color: colorRedBlue; signalUpdate.
			 ].
	c addAnimation: animation.
	"c newAnimation"
	^ c open
]

{ #category : 'accessing' }
RSAbstractAnimation >> allDuration [
	^  self duration * (self isRepeating
		ifTrue: [ 1 ]
		ifFalse: [ self loops ])
]

{ #category : 'announcer' }
RSAbstractAnimation >> announcementClasses [
	^ RSAnimationEvent subclasses
]

{ #category : 'announcer' }
RSAbstractAnimation >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : 'accessing' }
RSAbstractAnimation >> canvas [
	^ canvas
]

{ #category : 'accessing' }
RSAbstractAnimation >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : 'actions' }
RSAbstractAnimation >> continue [
	isPaused ifFalse: [ ^ self ].
	isPaused := false.
	endPauseTime := self currentTime.
	pauseTime := pauseTime + endPauseTime - startPauseTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> currentLoop [
	^ currentLoop
]

{ #category : 'private' }
RSAbstractAnimation >> currentTime [
	^ canvas currentTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> delay [
	^ delay
]

{ #category : 'accessing' }
RSAbstractAnimation >> delay: aDuration [
	delay := aDuration asMilliSeconds
]

{ #category : 'accessing' }
RSAbstractAnimation >> duration [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractAnimation >> endPauseTime [
	^ endPauseTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> endTime [
	^ endTime
]

{ #category : 'testing' }
RSAbstractAnimation >> hasCompleted [
	 ^ hasCompleted
]

{ #category : 'initialization' }
RSAbstractAnimation >> initialize [
	super initialize.
	self reset.
	canvas := RSDefaultTimer new
]

{ #category : 'testing' }
RSAbstractAnimation >> isDelayDone [
	delay ifNil: [ ^ true ].
	^ startTime + delay  + pauseTime < self currentTime
]

{ #category : 'testing' }
RSAbstractAnimation >> isPaused [
	^ isPaused
]

{ #category : 'testing' }
RSAbstractAnimation >> isRepeating [
	^ loops isInfinite
]

{ #category : 'testing' }
RSAbstractAnimation >> isRunning [
	^ isRunning
]

{ #category : 'private' }
RSAbstractAnimation >> loopDone [
	currentLoop := currentLoop + 1.
	startPauseTime := endPauseTime := pauseTime := 0.
	firstStep := true.
	startLoopTime := self currentTime.
	self announce: (RSAnimationLoopEvent new animation: self)
]

{ #category : 'accessing' }
RSAbstractAnimation >> loops [
	^ loops
]

{ #category : 'accessing' }
RSAbstractAnimation >> loops: aNumber [
	self assert: aNumber >= 1 description: 'The number of times to repeat this animation'.
	loops := aNumber
]

{ #category : 'api - running' }
RSAbstractAnimation >> noRepeat [
	self loops: 1
]

{ #category : 'actions' }
RSAbstractAnimation >> pause [
	isPaused ifTrue: [ ^ self ].
	isPaused := true.
	startPauseTime := self currentTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> pauseTime [
	^ pauseTime
]

{ #category : 'announcer' }
RSAbstractAnimation >> privateAnnouncer [
	^ announcer
]

{ #category : 'refreshing' }
RSAbstractAnimation >> refresh [
	self hasCompleted
		ifTrue: [ ^ self ].
	self isDelayDone
		ifFalse: [ ^ self ].
	self isPaused
		ifTrue: [ ^ self ].
	firstStep ifTrue: [
		firstStep := false.
		pauseTime := 0.
		self announce: (RSAnimationStartEvent new animation: self)
		 ].
	self step
]

{ #category : 'dependencies' }
RSAbstractAnimation >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : 'actions' }
RSAbstractAnimation >> remove [
	canvas animations remove: self ifAbsent: [  ].
	endTime := self currentTime.
	isRunning := false.
	currentLoop := nil.
	startLoopTime := nil.
	self announce: (RSAnimationEndEvent new animation: self)
]

{ #category : 'api - running' }
RSAbstractAnimation >> repeat [
	"make receiver to be a repeating timer"
	self loops: Float infinity
]

{ #category : 'initialization' }
RSAbstractAnimation >> reset [
	isRunning := false.
	firstStep := true.
	self noRepeat.
	hasCompleted := false.
	isPaused := false.
	currentLoop := nil.
	startLoopTime := nil.
	startPauseTime := 0.
	endPauseTime := 0.
	pauseTime := 0
]

{ #category : 'actions' }
RSAbstractAnimation >> start [
	isRunning := true.
	hasCompleted := false.
	startTime := self currentTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> startLoopTime [
	^ startLoopTime
]

{ #category : 'accessing' }
RSAbstractAnimation >> startPauseTime [
	^ startPauseTime
]

{ #category : 'private' }
RSAbstractAnimation >> startStep [
	currentLoop
		ifNil: [ currentLoop := 0 ].
	startLoopTime
		ifNil: [ startLoopTime := self currentTime ]
]

{ #category : 'accessing' }
RSAbstractAnimation >> startTime [
	^ startTime
]

{ #category : 'refreshing' }
RSAbstractAnimation >> step [
	self subclassResponsibility
]

{ #category : 'actions' }
RSAbstractAnimation >> stop [
	isRunning := false.
	hasCompleted := true
]

{ #category : 'actions' }
RSAbstractAnimation >> toggle [
	self isPaused
		ifTrue: [ self continue ]
		ifFalse: [ self pause ]
]

{ #category : 'private' }
RSAbstractAnimation >> updateHasCompleted [
	hasCompleted ifFalse: [ hasCompleted := currentLoop >= loops ]
]
