"
I have two ranges the start an the stop
"
Class {
	#name : #TSAbstractInterpolator,
	#superclass : #TSInterpolator,
	#instVars : [
		'start',
		'stop'
	],
	#category : #'Roassal3-Scales-Core'
}

{ #category : #accessing }
TSAbstractInterpolator >> start: anObject [
	start := anObject
]

{ #category : #accessing }
TSAbstractInterpolator >> stop: anObject [
	stop := anObject
]
