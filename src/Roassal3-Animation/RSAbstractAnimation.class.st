"
I am the abstract class that defines animations for roassal3
"
Class {
	#name : #RSAbstractAnimation,
	#superclass : #RSObject,
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

{ #category : #events }
RSAbstractAnimation >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #events }
RSAbstractAnimation >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #events }
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
	^ Time millisecondClockValue 
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
		ifNil: [ currentLoop := 1 ].
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

{ #category : #events }
RSAbstractAnimation >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
