"
Too abstract at this point, do we need instances of RSElement?
"
Class {
	#name : #RSElement,
	#superclass : #RSObject,
	#instVars : [
		'model',
		'index'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSElement >> model [
	^ model
]

{ #category : #accessing }
RSElement >> model: anObject [
	model := anObject
]
