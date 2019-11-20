"
Abstract renderer for UML
"
Class {
	#name : #RSAbstractUMLRenderer,
	#superclass : #RSObject,
	#instVars : [
		'border',
		'modelDescriptor',
		'textColor',
		'layout'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLRenderer class >> isAbstract [ 

	^self name = #RSAbstractUMLRenderer
]

{ #category : #accessing }
RSAbstractUMLRenderer >> border [
	^ border ifNil: [ border := self defaultBorder ].
]

{ #category : #accessing }
RSAbstractUMLRenderer >> border: aBorder [
	border := aBorder
]

{ #category : #defaults }
RSAbstractUMLRenderer >> defaultBorder [
	^ RSBorder new
		color: self textColor;
		yourself
]

{ #category : #accessing }
RSAbstractUMLRenderer >> defaultLayout [
	^ self subclassResponsibility
]

{ #category : #defaults }
RSAbstractUMLRenderer >> defaultTextColor [
	^ Color black
]

{ #category : #accessing }
RSAbstractUMLRenderer >> layout [
	^ layout ifNil: [ layout := self defaultLayout ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> modelDescriptor [
	^ modelDescriptor
]

{ #category : #accessing }
RSAbstractUMLRenderer >> modelDescriptor: aModelDescriptor [
	modelDescriptor := aModelDescriptor
]

{ #category : #hooks }
RSAbstractUMLRenderer >> setUpCanvas: aCanvas [
	"overridde me"
]

{ #category : #hooks }
RSAbstractUMLRenderer >> shapeFor: anObject [
	^ self subclassResponsibility
]

{ #category : #public }
RSAbstractUMLRenderer >> shapesFor: aCollection [
	^ aCollection collect: [ :obj | self shapeFor: obj ] as: RSGroup.
]

{ #category : #accessing }
RSAbstractUMLRenderer >> textColor [
	^ textColor ifNil: [ textColor := self defaultTextColor ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> textColor: aColor [
	textColor := aColor
]
