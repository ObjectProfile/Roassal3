"
Abstract renderer for UML
"
Class {
	#name : #RSAbstractUMLRenderer,
	#superclass : #RSObject,
	#instVars : [
		'border',
		'modelDescriptor'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLRenderer class >> isAbstract [ 

	^self name = #RSAbstractUMLRenderer
]

{ #category : #defaults }
RSAbstractUMLRenderer >> border [
	^ border ifNil: [ border := TSBorder new ].
]

{ #category : #defaults }
RSAbstractUMLRenderer >> defaultBorder [
	^ TSBorder new
]

{ #category : #initialization }
RSAbstractUMLRenderer >> initialize [
	super initialize.
	self initializeShape
]

{ #category : #'private - initialization' }
RSAbstractUMLRenderer >> initializeShape [
	"define the shape"
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractUMLRenderer >> modelDescriptor [
	^modelDescriptor
]

{ #category : #accessing }
RSAbstractUMLRenderer >> modelDescriptor: aModelDescriptor [
	modelDescriptor := aModelDescriptor
]
