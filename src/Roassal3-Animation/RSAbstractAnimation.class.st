"
I am the abstract class that defines animations for roassal3
"
Class {
	#name : #RSAbstractAnimation,
	#superclass : #RSObject,
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
		'canvas'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #public }
RSAbstractAnimation class >> defaultDuration [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractAnimation >> allDuration [
	^  self duration * (self isRepeating
		ifTrue: [ 1 ]
		ifFalse: [ self loops ])
]

{ #category : #announcer }
RSAbstractAnimation >> announcementClasses [
	^ RSAnimationEvent subclasses
]

{ #category : #announcer }
RSAbstractAnimation >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
RSAbstractAnimation >> canvas [
	^ canvas 
]

{ #category : #accessing }
RSAbstractAnimation >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #actions }
RSAbstractAnimation >> continue [
	isPaused ifFalse: [ ^ self ].
	isPaused := false.
	endPauseTime := self currentTime.
	pauseTime := pauseTime + endPauseTime - startPauseTime.
]

{ #category : #accessing }
RSAbstractAnimation >> currentLoop [
	^ currentLoop
]

{ #category : #private }
RSAbstractAnimation >> currentTime [
	^ canvas currentTime
]

{ #category : #accessing }
RSAbstractAnimation >> delay [ 
	^ delay
]

{ #category : #accessing }
RSAbstractAnimation >> delay: aDuration [
	delay := aDuration asMilliSeconds
]

{ #category : #accessing }
RSAbstractAnimation >> duration [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractAnimation >> endPauseTime [
	^ endPauseTime
]

{ #category : #accessing }
RSAbstractAnimation >> endTime [
	^ endTime
]

{ #category : #testing }
RSAbstractAnimation >> hasCompleted [
	 ^ hasCompleted
]

{ #category : #initialization }
RSAbstractAnimation >> initialize [
	super initialize.
	self reset.
	canvas := RSDefaultTimer new.
]

{ #category : #testing }
RSAbstractAnimation >> isDelayDone [
	delay ifNil: [ ^ true ].
	^ startTime + delay < self currentTime.
]

{ #category : #testing }
RSAbstractAnimation >> isPaused [
	^ isPaused
]

{ #category : #testing }
RSAbstractAnimation >> isRepeating [
	^ loops isInfinite.
]

{ #category : #testing }
RSAbstractAnimation >> isRunning [ 
	^ isRunning
]

{ #category : #private }
RSAbstractAnimation >> loopDone [
	currentLoop := currentLoop + 1.
	startPauseTime := endPauseTime := pauseTime := 0.
	startLoopTime := self currentTime.
	self announce: (RSAnimationLoopEvent new animation: self).
]

{ #category : #accessing }
RSAbstractAnimation >> loops [
	^ loops
]

{ #category : #accessing }
RSAbstractAnimation >> loops: aNumber [
	self assert: aNumber >= 1 description: 'The number of times to repeat this animation'.
	loops := aNumber
]

{ #category : #'api - running' }
RSAbstractAnimation >> noRepeat [
	self loops: 1
]

{ #category : #actions }
RSAbstractAnimation >> pause [
	isPaused ifTrue: [ ^ self ].
	isPaused := true.
	startPauseTime := self currentTime.
	
]

{ #category : #accessing }
RSAbstractAnimation >> pauseTime [
	^ pauseTime
]

{ #category : #announcer }
RSAbstractAnimation >> privateAnnouncer [
	^ announcer
]

{ #category : #refresing }
RSAbstractAnimation >> refresh [
	self hasCompleted
		ifTrue: [ ^ self ].
	self isDelayDone
		ifFalse: [ ^ self ].
	self isPaused 
		ifTrue: [ ^ self ].
	self step.
	
]

{ #category : #dependencies }
RSAbstractAnimation >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #actions }
RSAbstractAnimation >> remove [
	canvas animations remove: self ifAbsent: [  ].
	endTime := self currentTime.
	isRunning := false.
	currentLoop := nil.
	startLoopTime := nil.
	self announce: (RSAnimationEndEvent new animation: self)
	
]

{ #category : #'api - running' }
RSAbstractAnimation >> repeat [
	"make receiver to be a repeating timer"
	self loops: Float infinity
]

{ #category : #initialization }
RSAbstractAnimation >> reset [
	isRunning := false.
	self noRepeat.
	hasCompleted := false.
	isPaused := false.
	currentLoop := nil.
	startLoopTime := nil.
	startPauseTime := 0.
	endPauseTime := 0.
	pauseTime := 0.
]

{ #category : #actions }
RSAbstractAnimation >> start [
	isRunning := true.
	hasCompleted := false.
	startTime := self currentTime.
	self announce: (RSAnimationStartEvent new animation: self)
]

{ #category : #accessing }
RSAbstractAnimation >> startLoopTime [
	^ startLoopTime 
]

{ #category : #accessing }
RSAbstractAnimation >> startPauseTime [
	^ startPauseTime
]

{ #category : #private }
RSAbstractAnimation >> startStep [
	currentLoop 
		ifNil: [ currentLoop := 0 ].
	startLoopTime 
		ifNil: [ startLoopTime := self currentTime ].
]

{ #category : #accessing }
RSAbstractAnimation >> startTime [
	^ startTime 
]

{ #category : #refresing }
RSAbstractAnimation >> step [
	self subclassResponsibility
]

{ #category : #actions }
RSAbstractAnimation >> stop [
	isRunning := false.
	hasCompleted := true.
]

{ #category : #actions }
RSAbstractAnimation >> toggle [
	self isPaused 
		ifTrue: [ self continue ]
		ifFalse: [ self pause ]
]

{ #category : #private }
RSAbstractAnimation >> updateHasCompleted [
	hasCompleted ifFalse: [ hasCompleted := currentLoop >= loops ].
]
