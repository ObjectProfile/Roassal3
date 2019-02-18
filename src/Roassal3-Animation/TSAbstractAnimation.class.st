"
I am the abstract class that defines animations for roassal3
"
Class {
	#name : #TSAbstractAnimation,
	#superclass : #TSObject,
	#instVars : [
		'onFinished',
		'progress',
		'isRunning',
		'elapsedTime'
	],
	#category : #'Roassal3-Animation'
}

{ #category : #accessing }
TSAbstractAnimation >> elapsedTime [
	^elapsedTime 
]

{ #category : #'api - running' }
TSAbstractAnimation >> executeOnFinish [
	onFinished isNil ifTrue: [ ^ self ].
	onFinished value.
]

{ #category : #testing }
TSAbstractAnimation >> hasCompleted [
	 ^ false
]

{ #category : #initialization }
TSAbstractAnimation >> initialize [
	super initialize.
	self reset
]

{ #category : #testing }
TSAbstractAnimation >> isRunning [
	^ isRunning
]

{ #category : #accessing }
TSAbstractAnimation >> onFinished [
	
	^ onFinished
]

{ #category : #accessing }
TSAbstractAnimation >> onFinished: block [
	onFinished := block
]

{ #category : #initialization }
TSAbstractAnimation >> reset [
	elapsedTime := 0 milliSeconds.
	progress := 0.0.
	isRunning := false.
]

{ #category : #'api - running' }
TSAbstractAnimation >> start [
	progress := 0.
	elapsedTime := 0 milliSeconds.
	isRunning := true.
]
