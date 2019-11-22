"
An abstract builder for UML shapes based on a model description (like a class or package description)
"
Class {
	#name : #RSUMLAbstractBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'renderer',
		'modelDescriptor'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #testing }
RSUMLAbstractBuilder class >> isAbstract [ 
	^self name = #RSUMLAbstractBuilder
]

{ #category : #private }
RSUMLAbstractBuilder >> defaultContainer [
	^ RSCanvas new 
		addInteraction: RSCanvasController new;
		yourself.
]

{ #category : #accessing }
RSUMLAbstractBuilder >> initialize [
	super initialize.
	shapes := RSGroup new.
]

{ #category : #accessing }
RSUMLAbstractBuilder >> layout [
	^ renderer layout
]

{ #category : #accessing }
RSUMLAbstractBuilder >> modelDescriptor [
	^ modelDescriptor
]

{ #category : #accessing }
RSUMLAbstractBuilder >> modelDescriptor: aRSClassDescriptor [
	modelDescriptor := aRSClassDescriptor.
	renderer ifNotNil: [ renderer modelDescriptor: modelDescriptor ].
]

{ #category : #hooks }
RSUMLAbstractBuilder >> renderIn: aView [
	self subclassResponsibility 
]

{ #category : #accessing }
RSUMLAbstractBuilder >> renderer [
	^ renderer
]

{ #category : #accessing }
RSUMLAbstractBuilder >> renderer: aRSUMLRenderer [
	renderer := aRSUMLRenderer.
	renderer modelDescriptor: modelDescriptor
]
