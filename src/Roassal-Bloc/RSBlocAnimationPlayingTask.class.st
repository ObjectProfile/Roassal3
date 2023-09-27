"
I'm a task that re-enqueues on every frame and does nothing when the Roassal canvas has no animations.
"
Class {
	#name : #RSBlocAnimationPlayingTask,
	#superclass : #BlTask,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal-Bloc-Core'
}

{ #category : #'private - testing' }
RSBlocAnimationPlayingTask >> requeueTaskAfterExecution [

	^ true
]

{ #category : #accessing }
RSBlocAnimationPlayingTask >> roassalCanvas [

	^ roassalCanvas
]

{ #category : #accessing }
RSBlocAnimationPlayingTask >> roassalCanvas: anObject [

	roassalCanvas := anObject
]

{ #category : #'api - running' }
RSBlocAnimationPlayingTask >> run [

	roassalCanvas hasAnimation ifTrue: [ roassalCanvas playAnimations ]
]
