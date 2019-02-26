"
I have test for animation in trachel
"
Class {
	#name : #TSAnimationTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Animation'
}

{ #category : #tests }
TSAnimationTest >> testBasic [ 
	| animation |
	animation := TSNumberAnimation new.
	self assert: animation loops equals: 1.
	self deny: animation hasCompleted.
	
	self deny: animation isRunning.
	self assert: animation startTime isNil.
	self deny: animation isPaused.
	animation start.
	self assert: animation isRunning.
	self deny: animation startTime isNil.
	self deny: animation isPaused.
	
	animation pause.
	self assert: animation isPaused.
	animation continue.
	self deny: animation isPaused.
	
	self assert: animation loops equals: 1.
	self should: [animation loops: 0 ] raise: Error.
	animation loops: 3.
	self assert: animation loops equals: 3.
]

{ #category : #tests }
TSAnimationTest >> testBasicCanvas [
	
	| canvas animation |
	canvas := TSCanvas new.
	
	self assert: canvas animations size equals: 0.
	animation := canvas animation.
	self assert: canvas animations size equals: 1.
	
	self assert: animation isRunning.
	self assert: animation duration equals: 2 asSeconds.
]

{ #category : #tests }
TSAnimationTest >> testDelay [
	
	| canvas animation |
	canvas := TSCanvas new.
	animation := canvas animation
		delay: 100 milliSeconds.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 101) wait.
	self assert: animation isDelayDone.
	
]

{ #category : #tests }
TSAnimationTest >> testStep [
	
	| canvas value |
	canvas := TSCanvas new.
	value := 0.
	canvas animation
		onStepDo: [ :t| value := value + 1 ].
		
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 1.
]

{ #category : #tests }
TSAnimationTest >> testStepEvent [
	
	| value loop ended time canvas animation |
	canvas := TSCanvas new.
	value := nil.
	loop := 0.
	ended := false.
	animation := canvas animation
		duration: 100 milliSeconds;
		loops: 3;
		onStepDo: [ :t| value := t ];
		when: TSAnimationLoopEvent do: [ :evt | loop := loop + 1.];
		when: TSAnimationEndEvent do: [ :evt | ended := true ].
	self assert: value isNil.
	self assert: loop equals: 0.
	self assert: animation endTime isNil.
	time := Time now asDuration.
	[ ended ] whileFalse: [ 
		(Time now asDuration - time) > 310 milliSeconds ifTrue: [ 
			"time up"
			self error: 'Time up'.
			^ self ].
		canvas playAnimations.
		].
	self deny: value isNil.
	self assert: loop equals: 3.
	self deny: animation endTime isNil.
	self deny: animation isRunning.
]
