"
Super class of composite animations
"
Class {
	#name : 'RSCompositeAnimation',
	#superclass : 'RSAbstractAnimation',
	#instVars : [
		'animations'
	],
	#category : 'Roassal-Animation-Core',
	#package : 'Roassal-Animation',
	#tag : 'Core'
}

{ #category : 'accessing - defaults' }
RSCompositeAnimation class >> defaultDuration [
	^ 0 seconds
]

{ #category : 'adding' }
RSCompositeAnimation >> add: anAnimation [
	animations add: anAnimation
]

{ #category : 'adding' }
RSCompositeAnimation >> addAll: array [
	animations addAll: array
]

{ #category : 'accessing' }
RSCompositeAnimation >> animations [
	^ animations
]

{ #category : 'initialization' }
RSCompositeAnimation >> reset [
	super reset.
	animations := OrderedCollection new
]

{ #category : 'private' }
RSCompositeAnimation >> startIfNessesary: animation [
	animation isRunning ifTrue: [ ^ self ].
	animation canvas: self canvas.
	animation start
]
