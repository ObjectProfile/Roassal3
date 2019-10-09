"
An abstract builder for UML shapes based on a model description (like a class or package description)
"
Class {
	#name : #RSUMLAbstractBuilder,
	#superclass : #RSAbstractViewBuilder,
	#instVars : [
		'renderer',
		'modelDescriptor',
		'layout'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #testing }
RSUMLAbstractBuilder class >> isAbstract [ 
	^self name = #RSUMLAbstractBuilder
]

{ #category : #defaults }
RSUMLAbstractBuilder >> defaultLayout [

	^self subclassResponsibility
]

{ #category : #accessing }
RSUMLAbstractBuilder >> layout [

	^layout ifNil: [ layout := self defaultLayout ]
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
	renderer modelDescriptor: modelDescriptor.
	self initializeShape.
]

{ #category : #accessing }
RSUMLAbstractBuilder >> view [
	^ container ifNil: [
		container := RSView new.
		container @ TSControlsCanvas.
		container ]
]
