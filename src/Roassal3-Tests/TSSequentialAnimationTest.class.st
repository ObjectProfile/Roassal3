"
I have test for sequential animation
"
Class {
	#name : #TSSequentialAnimationTest,
	#superclass : #TSAnimationTest,
	#category : #'Roassal3-Tests-Animation'
}

{ #category : #tests }
TSSequentialAnimationTest >> testAddingAnimations [
	|  animation |
	animation := TSSequentialAnimation new.
	animation
		add: (TSTransitionAnimation new
			duration: 1 second);
		add: (TSTransitionAnimation new
			duration: 2 seconds).
	canvas addAnimation: animation.
	self assert: animation isRunning.
	self assert: animation duration equals: 3 seconds.
]

{ #category : #tests }
TSSequentialAnimationTest >> testBasic [
	self basicAnimation: TSSequentialAnimation new.
]

{ #category : #tests }
TSSequentialAnimationTest >> testBasicCanvas [
	
	|  animation |
	
	self assert: canvas animations size equals: 0.
	animation := canvas animation: TSSequentialAnimation new.
	self assert: canvas animations size equals: 1.
	
	self assert: animation isRunning.
	self assert: animation duration equals: 0 asDuration.
]

{ #category : #tests }
TSSequentialAnimationTest >> testDelay [
	
	| animation |
	animation := TSSequentialAnimation new
		delay: 100 milliSeconds.
	animation start.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 101) wait.
	self assert: animation isDelayDone.
	
]

{ #category : #tests }
TSSequentialAnimationTest >> testStep [
	
	| value animation |
	value := 0.
	animation := TSSequentialAnimation new
		add: (TSTransitionAnimation new 
			onStepDo: [ :t| value := value + 1 ]);
		yourself.
	canvas addAnimation: animation.
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 1.
]

{ #category : #tests }
TSSequentialAnimationTest >> testStepEvent [
	| value loop animation |
	canvas := TSCanvas new.
	value := nil.
	loop := 0.
	animation := TSSequentialAnimation new
		loops: 3;
		add: (TSTransitionAnimation new 
			duration: 100 milliSeconds;
			onStepDo: [ :t| value := t ]);
		when: TSAnimationLoopEvent do: [ :evt | loop := loop + 1.].
	canvas addAnimation: animation.
	self assert: value isNil.
	self assert: loop equals: 0.
	self assert: animation endTime isNil.
	self runAnimation: animation threshold: 310.
	self deny: value isNil.
	self assert: loop equals: 3.
	self deny: animation endTime isNil.
	self deny: animation isRunning.
]
