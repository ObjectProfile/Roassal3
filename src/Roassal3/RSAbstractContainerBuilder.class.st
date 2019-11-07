"
I am an abstract class to describe all container builders
"
Class {
	#name : #RSAbstractContainerBuilder,
	#superclass : #RSObject,
	#instVars : [
		'container',
		'shapes'
	],
	#category : #'Roassal3-Core'
}

{ #category : #building }
RSAbstractContainerBuilder >> build [
	self renderIn: self container
]

{ #category : #accessing }
RSAbstractContainerBuilder >> canvas [
	^ self container canvas
]

{ #category : #accessing }
RSAbstractContainerBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ].
]

{ #category : #accessing }
RSAbstractContainerBuilder >> container: aTContainer [
	container := aTContainer
]

{ #category : #private }
RSAbstractContainerBuilder >> defaultContainer [
	^ RSCanvas new
]

{ #category : #hooks }
RSAbstractContainerBuilder >> renderIn: aCanvas [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractContainerBuilder >> shapes [
	^ shapes
]
