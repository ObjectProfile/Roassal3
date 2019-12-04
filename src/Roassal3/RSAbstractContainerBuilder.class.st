"
I am an abstract class to describe all container builders
"
Class {
	#name : #RSAbstractContainerBuilder,
	#superclass : #RSObject,
	#instVars : [
		'container',
		'shapes',
		'decorators'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #decoration }
RSAbstractContainerBuilder >> addDecorator: aRSDecorator [
	aRSDecorator builder: self.
	self decorators add: aRSDecorator
]

{ #category : #building }
RSAbstractContainerBuilder >> build [
	self fullRenderIn: self container
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

{ #category : #decoration }
RSAbstractContainerBuilder >> decorators [
	^ decorators ifNil: [ decorators := OrderedCollection new ]
]

{ #category : #defaults }
RSAbstractContainerBuilder >> defaultContainer [
	^ RSCanvas new
]

{ #category : #rendering }
RSAbstractContainerBuilder >> fullRenderIn: aContainer [
	self
		renderIn: aContainer;
		renderDecoratorsIfNecessary: aContainer.
]

{ #category : #testing }
RSAbstractContainerBuilder >> hasDecorators [
	^ decorators notNil and: [ decorators isNotEmpty ]
]

{ #category : #rendering }
RSAbstractContainerBuilder >> renderDecoratorsIfNecessary: aContainer [
	self hasDecorators ifFalse: [ ^ self ].
	decorators do: #render
]

{ #category : #hooks }
RSAbstractContainerBuilder >> renderIn: aCanvas [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractContainerBuilder >> shapes [
	^ shapes
]
