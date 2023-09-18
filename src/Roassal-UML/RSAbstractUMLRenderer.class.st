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
		'layout',
		'boxBorder',
		'boxColor'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLRenderer class >> isAbstract [

	^self name = #RSAbstractUMLRenderer
]

{ #category : #accessing }
RSAbstractUMLRenderer >> border [
	^ border ifNil: [ border := self defaultBorder ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> border: aBorder [
	border := aBorder
]

{ #category : #accessing }
RSAbstractUMLRenderer >> boxBorder [
	^ boxBorder ifNil: [ boxBorder := self defaultBoxBorder ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> boxBorder: aBorder [
	boxBorder := aBorder
]

{ #category : #accessing }
RSAbstractUMLRenderer >> boxColor [
	^ boxColor ifNil: [ boxColor := self defaultBoxColor ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> boxColor: aColor [
	boxColor := aColor
]

{ #category : #defaults }
RSAbstractUMLRenderer >> defaultBorder [
	^ RSBorder new
		color: self textColor;
		yourself
]

{ #category : #defaults }
RSAbstractUMLRenderer >> defaultBoxBorder [
	^ RSBorder new
		width: 5;
		joinMiter;
		color: '666EA0';
		yourself
]

{ #category : #accessing }
RSAbstractUMLRenderer >> defaultBoxColor [
	^ Color colorFrom: 'cfd9df'
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

{ #category : #accessing }
RSAbstractUMLRenderer >> textColor [
	^ textColor ifNil: [ textColor := self defaultTextColor ]
]

{ #category : #accessing }
RSAbstractUMLRenderer >> textColor: aColor [
	textColor := aColor
]
