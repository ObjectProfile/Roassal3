"
I am the default renderer that RSUMLClassBuilder 
"
Class {
	#name : #RSBasicUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'classInnerLine',
		'boxColor'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #hooks }
RSBasicUMLClassRenderer >> addLines: group title: title [ 
	| line rec |
	line := self classInnerLine.
	rec := group encompassingRectangle.
	group size > 2 ifTrue: [ 
		group add: (line copy
			startPoint: rec origin x @ title height;
			endPoint: rec corner x @ title height) ].
	group size > 4 ifTrue: [ 
		group add: (line copy
			startPoint: rec origin x @ (title height + group third height);
			endPoint: rec corner x @ (title height + group third height)) ].
]

{ #category : #accessing }
RSBasicUMLClassRenderer >> boxColor [ 
	^ boxColor ifNil: [ boxColor := self defaultBoxColor ]
]

{ #category : #accessing }
RSBasicUMLClassRenderer >> boxColor: aColor [
	boxColor := aColor
]

{ #category : #'accessing - shapes' }
RSBasicUMLClassRenderer >> classInnerLine [
	^ classInnerLine ifNil: [
		classInnerLine := RSLine new
			border: self border;
			yourself ]
]

{ #category : #'accessing - shapes' }
RSBasicUMLClassRenderer >> classInnerLine: aShape [
	classInnerLine := aShape
]

{ #category : #accessing }
RSBasicUMLClassRenderer >> defaultBoxColor [
	^ Color colorFrom: 'cfd9df'
]

{ #category : #hooks }
RSBasicUMLClassRenderer >> shapeFor: aClass [
	| shapes box title vars methods |
	title := self titleFor: aClass.
	vars := self varsFor: aClass.
	methods := self methodsFor: aClass.
	shapes := self groupFor: { vars. methods }.
	shapes addFirst: title.
	box := self classBoxShapeFor: aClass.
	self applyLayoutOn: shapes.
	self adjustTitle: title on: shapes.
	shapes addFirst: box.
	self adjustBox: box on: shapes. 
	self addLines: shapes title: title.
	^ RSComposite new
		popup;
		draggable;
		model: aClass;
		shapes: shapes;
		yourself.
]
