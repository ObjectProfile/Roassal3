"
I wait until one animation ends to start the another animation
"
Class {
	#name : #TSSequentialAnimation,
	#superclass : #TSAbstractAnimation,
	#instVars : [
		'animations',
		'currentIndex'
	],
	#category : #'Roassal3-Animation-Core'
}

{ #category : #adding }
TSSequentialAnimation >> add: anAnimation [
	self animations add: anAnimation 
]

{ #category : #adding }
TSSequentialAnimation >> addAll: array [
	animations addAll: array.
]

{ #category : #accessing }
TSSequentialAnimation >> animations [
	^ animations
]

{ #category : #actions }
TSSequentialAnimation >> continue [
	super continue.
	self currentDo: #continue.
]

{ #category : #refresing }
TSSequentialAnimation >> current [
	^ animations at: currentIndex ifAbsent: [ ^ nil ].
]

{ #category : #actions }
TSSequentialAnimation >> currentDo: block [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	block value: current.
]

{ #category : #refresing }
TSSequentialAnimation >> currentHasCompleted [
	| current |
	current := self current.
	current ifNil: [ ^ false ].
	^ current hasCompleted
]

{ #category : #accessing }
TSSequentialAnimation >> duration [
	^ Duration milliSeconds: (self animations inject: 0 into: [ :sum :a| sum + (a duration asMilliSeconds * a loops) ]).
]

{ #category : #actions }
TSSequentialAnimation >> pause [
	super pause.
	self currentDo: #pause.
]

{ #category : #initialization }
TSSequentialAnimation >> reset [
	super reset.
	animations := OrderedCollection new.
]

{ #category : #actions }
TSSequentialAnimation >> start [
	super start.
	currentIndex := 1.
]

{ #category : #refresing }
TSSequentialAnimation >> step [
	self startStep.
	self stepCurrent.
	self currentHasCompleted 
		ifTrue: [ currentIndex := currentIndex + 1. ].
	currentIndex > animations size ifTrue: [ 
		self animations do: #remove.
		currentIndex := 1.
		self loopDone ].
	hasCompleted := currentLoop > loops.
]

{ #category : #refresing }
TSSequentialAnimation >> stepCurrent [
	| current |
	current := self current.
	current ifNil: [ ^ self ].
	current isRunning ifFalse: [ 
		current canvas: self canvas.
		current start. ].
	current refresh.
]
