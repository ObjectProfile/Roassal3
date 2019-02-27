"
I have test for animation in trachel
"
Class {
	#name : #TSTransitionAnimationTest,
	#superclass : #TSAnimationTest,
	#category : #'Roassal3-Tests-Animation'
}

{ #category : #tests }
TSTransitionAnimationTest >> testBasic [ 
	self basicAnimation: TSTransitionAnimation new
]

{ #category : #tests }
TSTransitionAnimationTest >> testBasicCanvas [
	
	|  animation |
	
	self assert: canvas animations size equals: 0.
	animation := canvas animation.
	self assert: canvas animations size equals: 1.
	
	self assert: animation isRunning.
	self assert: animation duration equals: 2 asSeconds.
]

{ #category : #tests }
TSTransitionAnimationTest >> testDelay [
	
	| animation |
	animation := canvas animation
		delay: 100 milliSeconds.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 101) wait.
	self assert: animation isDelayDone.
	
]

{ #category : #tests }
TSTransitionAnimationTest >> testStep [
	
	| value |
	value := 0.
	canvas animation
		onStepDo: [ :t| value := value + 1 ].
		
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 1.
]

{ #category : #tests }
TSTransitionAnimationTest >> testStepEvent [
	
	| value loop animation |
	canvas := TSCanvas new.
	value := nil.
	loop := 0.
	animation := canvas animation
		duration: 100 milliSeconds;
		loops: 3;
		onStepDo: [ :t| value := t ];
		when: TSAnimationLoopEvent do: [ :evt | loop := loop + 1.].
	self assert: value isNil.
	self assert: loop equals: 0.
	self assert: animation endTime isNil.
	self runAnimation: animation threshold: 310.
	self deny: value isNil.
	self assert: loop equals: 3.
	self deny: animation endTime isNil.
	self deny: animation isRunning.
]

{ #category : #tests }
TSTransitionAnimationTest >> testStepReset [
	
	| animation |
	animation := canvas animation
		duration: 100 milliSeconds.
	self runAnimation: animation threshold: 110.
	
	self deny: animation isRunning.
	self assert: animation currentLoop equals: nil.
	self assert: canvas animations size equals: 0.
	
	animation reset;
		duration: 100 milliSeconds.
	canvas addAnimation: animation.
	
	self assert: canvas animations size equals: 1.
	self runAnimation: animation threshold: 110.
]
