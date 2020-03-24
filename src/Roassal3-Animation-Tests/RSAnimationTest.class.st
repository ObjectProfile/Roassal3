"
base of animation tests
"
Class {
	#name : #RSAnimationTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSAnimationTest >> basicAnimation: animation [
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

{ #category : #running }
RSAnimationTest >> runAnimation: animation threshold: threshold [
	| time ended |
	
	ended := false.
	animation when: RSAnimationEndEvent do: [ :evt | ended := true ].
	time := Time now asDuration.
	[ ended ] whileFalse: [ 
		(Time now asDuration - time) > threshold milliSeconds ifTrue: [ 
			"time up"
			self error: 'Time up'.
			^ self ].
		canvas playAnimations.
		].
]

{ #category : #running }
RSAnimationTest >> setUp [
	canvas := RSCanvas new.
]

{ #category : #tests }
RSAnimationTest >> testSequentialAnimationCreation [
	| animation |
	self assert: canvas animations size equals: 0.
	animation := canvas animationFrom: {}.
	self assert: canvas animations size equals: 1.
	self assert: animation class equals: RSSequentialAnimation.
]

{ #category : #tests }
RSAnimationTest >> testTransitionAnimationCreation [
	| animation |
	self assert: canvas animations size equals: 0.
	animation := canvas newAnimation.
	self assert: canvas animations size equals: 1.
	self assert: animation class equals: RSTransitionAnimation.
]
