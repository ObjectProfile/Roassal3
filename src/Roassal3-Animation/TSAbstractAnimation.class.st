"
I am the abstract class that defines animations for roassal3
"
Class {
	#name : #TSAbstractAnimation,
	#superclass : #RSAnimation,
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
		'pauseTime'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #events }
TSAbstractAnimation >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #events }
TSAbstractAnimation >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TSAbstractAnimation >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #actions }
TSAbstractAnimation >> continue [
	"| oldPaused |
	oldPaused := isPaused.
	isPaused := false.
	oldPaused 
		ifTrue: [ endPauseTime := self currentTime. ]"
	isPaused ifFalse: [ ^ self ].
	isPaused := false.
	endPauseTime := self currentTime.
	pauseTime := pauseTime + endPauseTime - startPauseTime.
]

{ #category : #accessing }
TSAbstractAnimation >> currentLoop [
	^ currentLoop
]

{ #category : #private }
TSAbstractAnimation >> currentTime [
	^ Time millisecondClockValue 
]

{ #category : #accessing }
TSAbstractAnimation >> delay [ 
	^ delay
]

{ #category : #accessing }
TSAbstractAnimation >> delay: aDuration [
	delay := aDuration asMilliSeconds
]

{ #category : #accessing }
TSAbstractAnimation >> duration [
	^ self subclassResponsibility
]

{ #category : #accessing }
TSAbstractAnimation >> endPauseTime [
	^ endPauseTime
]

{ #category : #accessing }
TSAbstractAnimation >> endTime [
	^ endTime
]

{ #category : #testing }
TSAbstractAnimation >> hasCompleted [
	 ^ hasCompleted
]

{ #category : #initialization }
TSAbstractAnimation >> initialize [
	super initialize.
	self reset.
]

{ #category : #testing }
TSAbstractAnimation >> isDelayDone [
	delay ifNil: [ ^ true ].
	^ startTime + delay < self currentTime.
]

{ #category : #testing }
TSAbstractAnimation >> isPaused [
	^ isPaused
]

{ #category : #testing }
TSAbstractAnimation >> isRepeating [
	^ loops isInfinite.
]

{ #category : #testing }
TSAbstractAnimation >> isRunning [ 
	^ isRunning
]

{ #category : #private }
TSAbstractAnimation >> loopDone [
	currentLoop := currentLoop + 1.
	startPauseTime := endPauseTime := pauseTime := 0.
	startLoopTime := self currentTime.
	self announce: (TSAnimationLoopEvent new animation: self).
]

{ #category : #accessing }
TSAbstractAnimation >> loops [
	^ loops
]

{ #category : #accessing }
TSAbstractAnimation >> loops: aNumber [
	self assert: aNumber >= 1 description: 'The number of times to repeat this animation'.
	loops := aNumber
]

{ #category : #'api - running' }
TSAbstractAnimation >> noRepeat [
	self loops: 1
]

{ #category : #actions }
TSAbstractAnimation >> pause [
	isPaused ifTrue: [ ^ self ].
	isPaused := true.
	startPauseTime := self currentTime.
	
]

{ #category : #accessing }
TSAbstractAnimation >> pauseTime [
	^ pauseTime
]

{ #category : #refresing }
TSAbstractAnimation >> refresh [
	self hasCompleted
		ifTrue: [ ^ self ].
	self isDelayDone
		ifFalse: [ ^ self ].
	self isPaused 
		ifTrue: [ ^ self ].
	self step.
	
]

{ #category : #actions }
TSAbstractAnimation >> remove [
	canvas animations remove: self ifAbsent: [  ].
	endTime := self currentTime.
	isRunning := false.
	currentLoop := nil.
	startLoopTime := nil.
	self announce: (TSAnimationEndEvent new animation: self)
	
]

{ #category : #'api - running' }
TSAbstractAnimation >> repeat [
	"make receiver to be a repeating timer"
	self loops: Float infinity
]

{ #category : #initialization }
TSAbstractAnimation >> reset [
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
TSAbstractAnimation >> start [
	isRunning := true.
	hasCompleted := false.
	startTime := self currentTime.
	self announce: (TSAnimationStartEvent new animation: self)
]

{ #category : #accessing }
TSAbstractAnimation >> startLoopTime [
	^ startLoopTime 
]

{ #category : #accessing }
TSAbstractAnimation >> startPauseTime [
	^ startPauseTime
]

{ #category : #private }
TSAbstractAnimation >> startStep [
	currentLoop 
		ifNil: [ currentLoop := 1 ].
	startLoopTime 
		ifNil: [ startLoopTime := self currentTime ].
]

{ #category : #accessing }
TSAbstractAnimation >> startTime [
	^ startTime 
]

{ #category : #refresing }
TSAbstractAnimation >> step [
	self subclassResponsibility
]

{ #category : #actions }
TSAbstractAnimation >> stop [
	isRunning := false.
	hasCompleted := true.
]

{ #category : #actions }
TSAbstractAnimation >> toggle [
	self isPaused 
		ifTrue: [ self continue ]
		ifFalse: [ self pause ]
]

{ #category : #events }
TSAbstractAnimation >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
