"
I have test for animation in trachel
"
Class {
	#name : #RSTransitionAnimationTest,
	#superclass : #RSAnimationTest,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSTransitionAnimationTest >> testBasic [ 
	self basicAnimation: RSTransitionAnimation new
]

{ #category : #tests }
RSTransitionAnimationTest >> testBasicCanvas [
	|  animation |
	self assert: canvas animations size equals: 0.
	animation := canvas newAnimation.
	self assert: canvas animations size equals: 1.
	
	self assert: animation isRunning.
	self assert: animation duration equals: 2 asSeconds.
]

{ #category : #tests }
RSTransitionAnimationTest >> testDelay [
	| animation |
	animation := canvas newAnimation
		delay: 100 milliSeconds.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 101) wait.
	self assert: animation isDelayDone.
	
]

{ #category : #tests }
RSTransitionAnimationTest >> testStep [
	| value |
	value := 0.
	canvas newAnimation
		onStepDo: [ :t| value := value + 1 ].
		
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 1.
]

{ #category : #tests }
RSTransitionAnimationTest >> testStepEvent [
	| value loop animation |
	canvas := RSCanvas new.
	value := nil.
	loop := 0.
	animation := canvas newAnimation
		duration: 100 milliSeconds;
		loops: 3;
		onStepDo: [ :t| value := t ];
		when: RSAnimationLoopEvent do: [ :evt | loop := loop + 1.].
	self assert: value isNil.
	self assert: loop equals: 0.
	self assert: animation endTime isNil.
	self runAnimation: animation threshold: 3000.
	self deny: value isNil.
	self assert: loop equals: 3.
	self deny: animation endTime isNil.
	self deny: animation isRunning.
]

{ #category : #tests }
RSTransitionAnimationTest >> testStepReset [
	| animation |
	animation := canvas newAnimation
		duration: 100 milliSeconds.
	self runAnimation: animation threshold: 500.
	
	self deny: animation isRunning.
	self assert: animation currentLoop equals: nil.
	self assert: canvas animations size equals: 0.
	
	animation reset;
		duration: 100 milliSeconds.
	canvas addAnimation: animation.
	
	self assert: canvas animations size equals: 1.
	self runAnimation: animation threshold: 500.
]
