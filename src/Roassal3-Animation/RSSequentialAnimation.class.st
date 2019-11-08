"
I wait until one animation ends to start the another animation
"
Class {
	#name : #RSSequentialAnimation,
	#superclass : #RSAbstractAnimation,
	#instVars : [
		'animations',
		'currentIndex'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #adding }
RSSequentialAnimation >> add: anAnimation [
	self animations add: anAnimation 
]

{ #category : #adding }
RSSequentialAnimation >> addAll: array [
	animations addAll: array.
]

{ #category : #accessing }
RSSequentialAnimation >> animations [
	^ animations
]

{ #category : #actions }
RSSequentialAnimation >> continue [
	super continue.
	self currentDo: #continue.
]

{ #category : #refresing }
RSSequentialAnimation >> current [
	^ animations at: currentIndex ifAbsent: [ ^ nil ].
]

{ #category : #actions }
RSSequentialAnimation >> currentDo: block [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	block value: current.
]

{ #category : #refresing }
RSSequentialAnimation >> currentHasCompleted [
	| current |
	current := self current.
	current ifNil: [ ^ false ].
	^ current hasCompleted
]

{ #category : #accessing }
RSSequentialAnimation >> duration [
	^ Duration milliSeconds: (self animations inject: 0 into: [ :sum :a| sum + (a duration asMilliSeconds * a loops) ]).
]

{ #category : #actions }
RSSequentialAnimation >> pause [
	super pause.
	self currentDo: #pause.
]

{ #category : #initialization }
RSSequentialAnimation >> reset [
	super reset.
	animations := OrderedCollection new.
]

{ #category : #actions }
RSSequentialAnimation >> start [
	super start.
	currentIndex := 1.
]

{ #category : #refresing }
RSSequentialAnimation >> step [
	self startStep.
	self stepCurrent.
	self currentHasCompleted ifTrue: [ 
		self current remove.
		currentIndex := currentIndex + 1. ].
	currentIndex > animations size ifTrue: [ 
		currentIndex := 1.
		self loopDone ].
	hasCompleted ifFalse: [ hasCompleted := currentLoop > loops ].
]

{ #category : #refresing }
RSSequentialAnimation >> stepCurrent [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	current isRunning ifFalse: [ 
		current canvas: self canvas.
		current start. ].
	current refresh.
]
