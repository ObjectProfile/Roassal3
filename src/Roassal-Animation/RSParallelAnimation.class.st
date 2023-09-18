"
I excecute my animations at the same time
"
Class {
	#name : #RSParallelAnimation,
	#superclass : #RSCompositeAnimation,
	#category : #'Roassal3-Animation-Core'
}

{ #category : #actions }
RSParallelAnimation >> continue [
	super continue.
	animations do: #continue
]

{ #category : #accessing }
RSParallelAnimation >> duration [
	animations ifEmpty: [ ^ 0 asDuration ].
	^ (animations collect: #allDuration) max
]

{ #category : #actions }
RSParallelAnimation >> pause [
	super pause.
	animations do: #pause
]

{ #category : #actions }
RSParallelAnimation >> start [
	super start.
	animations do: [ :anime | self startIfNessesary: anime ]
]

{ #category : #refreshing }
RSParallelAnimation >> step [
	| activeAnimations activeSize |
	self startStep.
	activeAnimations := animations reject: [ :animation | animation hasCompleted ].
	activeSize := 0.
	activeAnimations do: [ :animation |
		self startIfNessesary: animation.
		animation refresh.
		animation hasCompleted
			ifTrue: [ animation remove ]
			ifFalse: [ activeSize := activeSize + 1 ] ].
	activeSize isZero ifTrue: [ self loopDone ].
	self updateHasCompleted
]
