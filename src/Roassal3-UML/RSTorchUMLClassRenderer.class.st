"
I am a second different way to draw an UML class, similar to the system Torch
"
Class {
	#name : #RSTorchUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'currentTitleWidth',
		'boxBorder',
		'titleBoxColor'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #hooks }
RSTorchUMLClassRenderer >> adjustBox: box on: shapes [
	shapes size = 3 ifTrue: [ padding := self classBoxPadding x @ 0 ].
	super adjustBox: box on: shapes
]

{ #category : #layout }
RSTorchUMLClassRenderer >> applyMLayoutOn: shapes [
	RSFlowLayout new 
		gapSize: 2;
		maxWidth: self currentMaxWidth;
		on: shapes.
]

{ #category : #layout }
RSTorchUMLClassRenderer >> applyVLayoutOn: shapes [
	self applyMLayoutOn: shapes
]

{ #category : #accessing }
RSTorchUMLClassRenderer >> boxBorder [
	^ boxBorder ifNil: [ boxBorder := self defaultBoxBorder ]
]

{ #category : #accessing }
RSTorchUMLClassRenderer >> boxBorder: aBorder [
	boxBorder := aBorder
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> classBoxShapeFor: aClass [
	^ RSBox new
		noPaint;
		border: self boxBorder;
		yourself
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> classNameBoxFor: aClass [ 
	^ RSBox new
		color: self titleBoxColor;
		yourself
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> currentMaxWidth [
	^ currentTitleWidth max: self minMethodsWidth
]

{ #category : #defaults }
RSTorchUMLClassRenderer >> defaultBoxBorder [
	^ RSBorder new
		width: 5; 
		joinMiter; 
		color: '666EA0';
		yourself 
]

{ #category : #defaults }
RSTorchUMLClassRenderer >> defaultLayout [
	^ super defaultLayout tree
		verticalGap: 50;
		horizontalGap: 10;
		yourself
]

{ #category : #defaults }
RSTorchUMLClassRenderer >> defaultTitleBoxColor [
	^ Color colorFrom: 'AFD2EE'
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> methodFor: aMethod [
	^ RSBox new
		width: 20;
		height: aMethod linesOfCode * 5 + 1;
		popup;
		yourself
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> methodsFor: aClass [
	^ (super methodsFor: aClass)
		padding: ( Margin 
		 	left: 0
			right: 0
			top: 5
			bottom: 5);
		yourself
]

{ #category : #'accessing - shapes' }
RSTorchUMLClassRenderer >> minMethodsWidth [
	^ 200
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> shapeFor: aClass [
	| shapes box title vars methods boxTitle |
	title := self titleFor: aClass.
	vars := self varsFor: aClass.
	methods := self methodsFor: aClass.
	shapes := self groupFor: { vars. methods }.
	shapes addFirst: title.
	box := self classBoxShapeFor: aClass.
	boxTitle := self classNameBoxFor: aClass.
	self applyLayoutOn: shapes.
	self adjustTitle: title on: shapes.
	shapes addFirst: boxTitle.
	shapes addLast: box.
	self adjustBox: box on: shapes. 
	boxTitle 
		position: box position x @ title position y ;
		extent: (box width @ title height).
	^ RSComposite new
		popup;
		draggable;
		model: aClass;
		shapes: shapes;
		yourself.
]

{ #category : #accessing }
RSTorchUMLClassRenderer >> titleBoxColor [
	^ titleBoxColor ifNil: [ titleBoxColor := self defaultTitleBoxColor ]
]

{ #category : #accessing }
RSTorchUMLClassRenderer >> titleBoxColor: aColor [
	titleBoxColor := aColor
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> titleFor: aClass [
	| s |
	s := super titleFor: aClass.
	currentTitleWidth := s textWidth.
	^ s
]

{ #category : #hooks }
RSTorchUMLClassRenderer >> varFor: model [
	^ RSPolygon triangle
		model: model;
		popup;
		size: 20;
		yourself
		
]
