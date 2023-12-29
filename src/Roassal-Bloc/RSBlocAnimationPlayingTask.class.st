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

{ #category : #'instance creation' }
RSBlocAnimationPlayingTask class >> newWithCanvas: aRSCanvas [

	^ self basicNew
		  initializeWithCanvas: aRSCanvas;
		  yourself
]

{ #category : #accessing }
RSBlocAnimationPlayingTask >> initializeWithCanvas: aRSCanvas [

	self initialize.
	roassalCanvas := aRSCanvas
]

{ #category : #'private - testing' }
RSBlocAnimationPlayingTask >> requeueTaskAfterExecution [

	^ true
]

{ #category : #'api - running' }
RSBlocAnimationPlayingTask >> run [

	roassalCanvas hasAnimation ifTrue: [ roassalCanvas playAnimations ]
]
