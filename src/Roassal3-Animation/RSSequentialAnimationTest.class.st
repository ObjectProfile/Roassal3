"
I have test for sequential animation
"
Class {
	#name : #RSSequentialAnimationTest,
	#superclass : #RSAnimationTest,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSSequentialAnimationTest >> testAddingAnimations [
	|  animation |
	animation := RSSequentialAnimation new.
	animation
		add: (RSTransitionAnimation new
			duration: 1 second);
		add: (RSTransitionAnimation new
			duration: 2 seconds).
	canvas addAnimation: animation.
	self assert: animation isRunning.
	self assert: animation duration equals: 3 seconds.
]

{ #category : #tests }
RSSequentialAnimationTest >> testBasic [
	self basicAnimation: RSSequentialAnimation new.
]

{ #category : #tests }
RSSequentialAnimationTest >> testBasicCanvas [
	|  animation |
	
	self assert: canvas animations size equals: 0.
	animation := RSSequentialAnimation new.
	canvas addAnimation: animation.
	self assert: canvas animations size equals: 1.
	
	self assert: animation isRunning.
	self assert: animation duration equals: 0 asDuration.
]

{ #category : #tests }
RSSequentialAnimationTest >> testDelay [
	| animation |
	animation := RSSequentialAnimation new
		delay: 100 milliSeconds.
	animation start.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 101) wait.
	self assert: animation isDelayDone.
	
]

{ #category : #tests }
RSSequentialAnimationTest >> testStep [
	| value animation |
	value := 0.
	animation := RSSequentialAnimation new
		add: (RSTransitionAnimation new 
			onStepDo: [ :t| value := value + 1 ]);
		yourself.
	canvas addAnimation: animation.
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 1.
]

{ #category : #tests }
RSSequentialAnimationTest >> testStepEvent [
	| value loop animation |
	canvas := RSCanvas new.
	value := nil.
	loop := 0.
	animation := RSSequentialAnimation new
		loops: 3;
		add: (RSTransitionAnimation new 
			duration: 100 milliSeconds;
			onStepDo: [ :t| value := t ]);
		when: RSAnimationLoopEvent do: [ :evt | loop := loop + 1.].
	canvas addAnimation: animation.
	self assert: value isNil.
	self assert: loop equals: 0.
	self assert: animation endTime isNil.
	self runAnimation: animation threshold: 500.
	self deny: value isNil.
	self assert: loop equals: 3.
	self deny: animation endTime isNil.
	self deny: animation isRunning.
]
