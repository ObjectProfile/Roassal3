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
		'elapsedTime',
		'canvas',
		'repeat',
		'cycleLenght'
	],
	#category : #'Roassal3-Trachel-Animation'
}

{ #category : #accessing }
TSAbstractAnimation >> canvas [
	^ canvas
]

{ #category : #accessing }
TSAbstractAnimation >> canvas: aCanvas [
	canvas := aCanvas
]

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
	repeat := false.
	cycleLenght := 1.0.
	super initialize.
	self reset
]

{ #category : #testing }
TSAbstractAnimation >> isRepeating [
	^ repeat 
]

{ #category : #testing }
TSAbstractAnimation >> isRunning [
	^ isRunning
]

{ #category : #'api - running' }
TSAbstractAnimation >> noRepeat [
	repeat := false 
]

{ #category : #accessing }
TSAbstractAnimation >> onFinished [
	
	^ onFinished
]

{ #category : #accessing }
TSAbstractAnimation >> onFinished: block [
	onFinished := block
]

{ #category : #refresing }
TSAbstractAnimation >> refresh [
]

{ #category : #'api - running' }
TSAbstractAnimation >> repeat [
	"make receiver to be a repeating timer"
	repeat := true 
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
