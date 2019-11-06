"
I am an abstract class to describe all container builders
"
Class {
	#name : #TSAbstractContainerBuilder,
	#superclass : #TSObject,
	#instVars : [
		'container',
		'shapes'
	],
	#category : #'Roassal3-Core'
}

{ #category : #building }
TSAbstractContainerBuilder >> build [
	self renderIn: self container
]

{ #category : #accessing }
TSAbstractContainerBuilder >> canvas [
	^ self container canvas
]

{ #category : #accessing }
TSAbstractContainerBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ].
]

{ #category : #accessing }
TSAbstractContainerBuilder >> container: aTContainer [
	container := aTContainer
]

{ #category : #private }
TSAbstractContainerBuilder >> defaultContainer [
	^ TSCanvas new
]

{ #category : #hooks }
TSAbstractContainerBuilder >> renderIn: aCanvas [
	self subclassResponsibility
]

{ #category : #accessing }
TSAbstractContainerBuilder >> shapes [
	^ shapes
]
