Class {
	#name : #RSPAnimationTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'canvas',
		'animationClass'
	],
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #'building suites' }
RSPAnimationTest class >> testParameters [
	| m classesToConsider |
	m := ParametrizedTestMatrix new.
	classesToConsider := RSAbstractAnimation allSubclasses select: [ :c | c subclasses isEmpty ].
	classesToConsider do: [ :cls |
		m addCase: { (#animationClass -> cls) }
	].
	^ m
]

{ #category : #accessing }
RSPAnimationTest >> animationClass [
	^ animationClass
]

{ #category : #accessing }
RSPAnimationTest >> animationClass: aClass [
	animationClass := aClass
]

{ #category : #running }
RSPAnimationTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #tests }
RSPAnimationTest >> testBasic [
	| animation |
	animation := self animationClass new.
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
	self assert: animation loops equals: 3
]

{ #category : #tests }
RSPAnimationTest >> testBasicInCanvas [
	| animation |
	animation := self animationClass new.
	canvas addAnimation: animation.
	self assert: canvas animations size equals: 1.

	self assert: animation isRunning.
	self assert: animation duration equals: self animationClass defaultDuration
]

{ #category : #tests }
RSPAnimationTest >> testDelay [
	| animation |
	animation := self animationClass new.
	animation delay: 100 milliSeconds.
	animation start.
	self deny: animation isDelayDone.
	(Delay forMilliseconds: 201) wait.
	self assert: animation isDelayDone
]

{ #category : #tests }
RSPAnimationTest >> testError [

	| c shape ani |
	c := RSCanvas new.

	shape := RSCircle new color: Color gray.
	c add: shape.

	ani := c newAnimation
				from: -50 @ -50;
				to: 100 @ 0.
	self should: [ ani on: shape set: #position ] raise: AssertionFailure
]
