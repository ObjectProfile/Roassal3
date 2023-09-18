"
I am the default renderer that RSUMLClassBuilder 
"
Class {
	#name : #RSBasicUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'classInnerLine',
		'popup'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #hooks }
RSBasicUMLClassRenderer >> addLines: group title: title [
	| line rec offset |
	line := self classInnerLine.
	rec := group encompassingRectangle.
	offset := 2.5.
	group size > 2 ifTrue: [
		group add: (line copy
			startPoint: (rec origin x + offset) @ title height;
			endPoint: (rec corner x - offset) @ title height) ].
	group size > 4 ifTrue: [
		group add: (line copy
			startPoint: (rec origin x + offset) @ (title height + group third height);
			endPoint: (rec corner x - offset) @ (title height + group third height)) ]
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

{ #category : #initialization }
RSBasicUMLClassRenderer >> initialize [
	super initialize.
	popup := RSPopup new model: #yourself.
	popup shapeBuilder: (RSAdaptativePopup new
		smallBuilder: popup shapeBuilder;
		bigBuilder: self;
		yourself)
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

	self createEllipsisIfNecessaryOn: shapes.
	shapes addFirst: box.
	self adjustBox: box on: shapes.
	self addLines: shapes title: title.
	^ RSComposite new
		draggable;
		addInteraction: popup;
		model: aClass;
		shapes: shapes;
		yourself
]
