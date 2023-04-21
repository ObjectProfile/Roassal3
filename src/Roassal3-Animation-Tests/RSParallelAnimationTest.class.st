Class {
	#name : #RSParallelAnimationTest,
	#superclass : #RSAnimationTest,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSParallelAnimationTest >> testAddingAnimations [
	self
		addingInComposite: canvas parallelAnimation
		duration: 2 second
]

{ #category : #tests }
RSParallelAnimationTest >> testDuration [
	| animation |
	animation := RSParallelAnimation new.
	self assert: animation duration equals: 0 seconds.

	animation := RSParallelAnimation new
		add: (RSTransitionAnimation new duration: 2 seconds);
		add: (RSTransitionAnimation new duration: 4 seconds);
		yourself.
	self assert: animation duration equals: 4 seconds.
	self assert: animation allDuration equals: 4 seconds.

	animation := RSParallelAnimation new
		loops: 5;
		add: (RSTransitionAnimation new duration: 2 seconds; loops: 5);
		add: (RSTransitionAnimation new duration: 4 seconds);
		yourself.
	self assert: animation duration equals: 10 seconds.
	self assert: animation allDuration equals: 50 seconds.

	animation := RSParallelAnimation new
		repeat;
		add: (RSTransitionAnimation new duration: 2 seconds; repeat);
		add: (RSTransitionAnimation new duration: 4 seconds);
		yourself.
	self assert: animation duration equals: 4 seconds.
	self assert: animation allDuration equals: 4 seconds
]

{ #category : #tests }
RSParallelAnimationTest >> testParallelAnimationCreation [
	self
		createAnimationWith: [ canvas parallelAnimationFrom: {} ]
		animationClass: RSParallelAnimation
]

{ #category : #tests }
RSParallelAnimationTest >> testStep [
	| value animation |
	value := 0.
	animation := RSParallelAnimation new
		add: (RSTransitionAnimation new
			onStepDo: [ :t| value := value + 1 ]);
		add: (RSTransitionAnimation new
			onStepDo: [ :t| value := value + 1 ]);
		yourself.
	canvas addAnimation: animation.
	self assert: value equals: 0.
	canvas playAnimations.
	self assert: value equals: 2
]

{ #category : #tests }
RSParallelAnimationTest >> testStepEvent [
	| value loop animation |
	value := nil.
	loop := 0.
	animation := RSParallelAnimation new
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
	self deny: animation isRunning
]
