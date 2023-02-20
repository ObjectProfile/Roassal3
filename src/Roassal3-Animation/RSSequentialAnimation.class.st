"
I wait until one animation ends to start the another animation
"
Class {
	#name : #RSSequentialAnimation,
	#superclass : #RSCompositeAnimation,
	#instVars : [
		'currentIndex'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #actions }
RSSequentialAnimation >> continue [
	super continue.
	self currentDo: #continue
]

{ #category : #refreshing }
RSSequentialAnimation >> current [
	^ animations at: currentIndex ifAbsent: [ nil ]
]

{ #category : #actions }
RSSequentialAnimation >> currentDo: block [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	block value: current
]

{ #category : #refreshing }
RSSequentialAnimation >> currentHasCompleted [
	| current |
	current := self current.
	current ifNil: [ ^ false ].
	^ current hasCompleted
]

{ #category : #accessing }
RSSequentialAnimation >> duration [
	animations ifEmpty: [ ^ 0 asDuration ].
	^ (animations collect: #allDuration) sum
]

{ #category : #actions }
RSSequentialAnimation >> pause [
	super pause.
	self currentDo: #pause
]

{ #category : #actions }
RSSequentialAnimation >> start [
	super start.
	currentIndex := 1
]

{ #category : #refreshing }
RSSequentialAnimation >> step [
	self startStep.
	self stepCurrent.
	self currentHasCompleted ifTrue: [
		self current remove.
		currentIndex := currentIndex + 1. ].
	currentIndex > animations size ifTrue: [
		currentIndex := 1.
		self loopDone ].
	self updateHasCompleted
]

{ #category : #refreshing }
RSSequentialAnimation >> stepCurrent [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	self startIfNessesary: current.
	current refresh
]
