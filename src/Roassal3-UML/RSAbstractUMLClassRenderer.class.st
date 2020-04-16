"
I have the roassal shapes to build the visualizacion
"
Class {
	#name : #RSAbstractUMLClassRenderer,
	#superclass : #RSAbstractUMLRenderer,
	#instVars : [
		'marker',
		'edgeBuilder',
		'padding',
		'currentClassMethods'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLClassRenderer class >> isAbstract [ 

	^self name = #RSAbstractUMLClassRenderer 
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> adjustBox: box on: shapes [ 
	| rect |
	rect := shapes encompassingRectangle.
	box
		extent: rect extent + self classBoxPadding;
		position: rect floatCenter.
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> adjustTitle: title on: shapes [ 
	title position: shapes encompassingRectangle floatCenter x @ title position y.
]

{ #category : #layout }
RSAbstractUMLClassRenderer >> applyLayoutOn: shapes [
	RSVerticalLineLayout new gapSize: 0; on: shapes.
]

{ #category : #layout }
RSAbstractUMLClassRenderer >> applyMLayoutOn: shapes [
	self applyLayoutOn: shapes
]

{ #category : #layout }
RSAbstractUMLClassRenderer >> applyVLayoutOn: shapes [
	self applyLayoutOn: shapes
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> classBoxPadding [
	^ padding ifNil: [ padding := self defaultClassBoxPadding ]
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> classBoxPadding: aPoint [
	padding := aPoint
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> classBoxShapeFor: aClass [ 
	^ RSBox new
		paint: self boxColor;
		cornerRadius: 10;
		border: self boxBorder;
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> createEllipsisIfNecessaryOn: aGroup [
	| rect ellipsis center |
	self needsEllipsis ifFalse: [ ^ self ].
	
	ellipsis := self ellipsisShape.
	rect := aGroup encompassingRectangle.
	center := rect floatCenter.
	ellipsis position: center x @ (rect height / 2 + center y).
	aGroup add: ellipsis.
	
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultClassBoxPadding [
	^ 10@10
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultEdgeBuilder [
	^ RSEdgeBuilder orthoVertical
		attachPoint: (RSVerticalAttachPoint new startOffset: 11);
		border: self border;
		markerStart: self marker;
		yourself
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultLayout [
	| defaultLayout |
	defaultLayout := RSLayoutBuilder new.
	defaultLayout tree 
		verticalGap: 50; 
		horizontalGap: 50.
	^ defaultLayout
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultMarker [
	^ RSMarker new 
		shape: (RSShapeFactory triangle
			color: Color white;
			border: self border;
			size: 20;
			yourself);
		yourself
]

{ #category : #edges }
RSAbstractUMLClassRenderer >> edgeBuilder [
	^ edgeBuilder ifNil: [ edgeBuilder := self defaultEdgeBuilder ]
]

{ #category : #edges }
RSAbstractUMLClassRenderer >> edgeBuilder: anEdgeBuilder [
	edgeBuilder := anEdgeBuilder
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> ellipsisShape [
	^ RSLabel new
		text: '...';
		color: self textColor;
		addInteraction: (RSPopup text: 'This class has more methods.' )
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> groupFor: shapes [
	^ RSGroup streamContents: [ :stream |
		shapes do: [ :s | s hasChildren ifTrue: [ stream << s ] ] ]. 
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> marker [ 
	^ marker ifNil: [ marker := self defaultMarker ]
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> marker: aMarker [
	marker := aMarker.
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> methodFor: method [
	^ RSLabel new
		model: method;
		color: self textColor;
		text: (modelDescriptor methodSelector rsValue: method);
		popup;
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> methodsFor: model [
	| shapes methods |
	methods := currentClassMethods := modelDescriptor methods rsValue: model.
	currentClassMethods size > modelDescriptor methodsLimit
		ifTrue: [ methods := currentClassMethods 
			copyFrom: 1 
			to: modelDescriptor methodsLimit ].
	shapes := methods collect: [ :met | self methodFor: met ].
	self applyMLayoutOn: shapes.
	^ RSComposite new
		shapes: shapes;
		yourself
]

{ #category : #testing }
RSAbstractUMLClassRenderer >> needsEllipsis [ 
	^ currentClassMethods isNotNil 
		and:  [ currentClassMethods size > modelDescriptor methodsLimit ]
		
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> titleFor: model [
	| label |
	label := RSLabel new
		color: self textColor;
		text: (modelDescriptor classname rsValue: model);
		yourself.
	label fontSize: label fontSize * 1.2.
	^ label
	
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> varFor: model [
	^ RSLabel new
		model: model;
		color: self textColor;
		text: model;
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> varsFor: model [
	| vars shapes |
	vars := modelDescriptor instVars rsValue: model.
	shapes := vars collect: [ :m | self varFor: m ].
	self applyVLayoutOn: shapes.
	^ RSComposite new
		shapes: shapes;
		yourself
		
]
