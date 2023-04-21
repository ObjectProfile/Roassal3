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
RSAnimationTest >> addingInComposite: compositeAnimation duration: aDuration [
	compositeAnimation
		add: (RSTransitionAnimation new
			duration: 1 second);
		add: (RSTransitionAnimation new
			duration: 2 seconds).
	canvas addAnimation: compositeAnimation.
	self assert: compositeAnimation isRunning.
	self assert: compositeAnimation duration equals: aDuration
]

{ #category : #tests }
RSAnimationTest >> createAnimationWith: block animationClass: class [
	| animation |
	self assert: canvas animations size equals: 0.
	animation := block value.
	self assert: canvas animations size equals: 1.
	self assert: animation class equals: class
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
		]
]

{ #category : #running }
RSAnimationTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]
