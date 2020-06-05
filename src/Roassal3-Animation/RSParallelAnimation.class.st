"
I excecute my animations at the same time
"
Class {
	#name : #RSParallelAnimation,
	#superclass : #RSCompositeAnimation,
	#category : #'Roassal3-Animation-Core'
}

{ #category : #accessing }
RSParallelAnimation >> duration [
	animations ifEmpty: [ ^ 0 asDuration ].
	^ (animations collect: #allDuration) max
]

{ #category : #refresing }
RSParallelAnimation >> step [
	| activeAnimations activeSize |
	self startStep.
	activeAnimations := animations reject: [ :animation | animation hasCompleted ].
	activeSize := 0.
	activeAnimations do: [ :animation | 
		animation isRunning ifFalse: [ 
			animation canvas: self canvas.
			animation start ].
		animation refresh.
		animation hasCompleted 
			ifTrue: [ animation remove ]
			ifFalse: [ activeSize := activeSize + 1 ] ].
	activeSize isZero ifTrue: [ self loopDone ].
	self updateHasCompleted.
	
	
]
