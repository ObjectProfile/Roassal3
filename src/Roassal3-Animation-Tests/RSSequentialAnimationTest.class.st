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
	self
		addingInComposite: canvas sequentialAnimation
		duration: 3 second
]

{ #category : #tests }
RSSequentialAnimationTest >> testDuration [
	| animation |
	animation := RSSequentialAnimation new.
	self assert: animation duration equals: 0 seconds.

	animation := RSSequentialAnimation new
		add: (RSTransitionAnimation new duration: 2 seconds);
		yourself.
	self assert: animation duration equals: 2 seconds.
	self assert: animation allDuration equals: 2 seconds.

	animation := RSSequentialAnimation new
		loops: 5;
		add: (RSTransitionAnimation new duration: 2 seconds; loops: 5);
		yourself.
	self assert: animation duration equals: 10 seconds.
	self assert: animation allDuration equals: 50 seconds.

	animation := RSSequentialAnimation new
		repeat;
		add: (RSTransitionAnimation new duration: 2 seconds;  repeat);
		yourself.
	self assert: animation duration equals: 2 seconds.
	self assert: animation allDuration equals: 2 seconds
]

{ #category : #tests }
RSSequentialAnimationTest >> testSequentialAnimationCreation [
	self
		createAnimationWith: [ canvas animationFrom: {} ]
		animationClass: RSSequentialAnimation
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
	self assert: value equals: 1
]

{ #category : #tests }
RSSequentialAnimationTest >> testStepEvent [
	| value loop animation |
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
	self deny: animation isRunning
]
