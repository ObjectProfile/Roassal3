"
I have the roassal shapes to build the visualizacion
"
Class {
	#name : #RSAbstractUMLClassRenderer,
	#superclass : #RSAbstractUMLRenderer,
	#instVars : [
		'marker',
		'edgeBuilder',
		'padding'
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
		position: rect rsCenter.
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> adjustTitle: title on: shapes [ 
	title position: shapes encompassingRectangle rsCenter x @ title position y.
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
	^ padding ifNil: [ padding := 10@10 ]
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
		border: self border;
		yourself
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
		verticalGap: 100; 
		horizontalGap: 50.
	^ defaultLayout
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultMarker [
	^ RSMarker new 
		shape: (RSPolygon triangle
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
		text: (modelDescriptor methodSelector rsValue: method) asString;
		popup;
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> methodsFor: model [
	| methods shapes |
	methods := modelDescriptor methods rsValue: model.
	shapes := methods collect: [ :met | self methodFor: met ].
	self applyMLayoutOn: shapes.
	^ RSComposite new
		shapes: shapes;
		yourself
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> titleFor: model [
	| label |
	label := RSLabel new
		color: self textColor;
		text: (modelDescriptor classname rsValue: model) asString;
		yourself.
	label fontSize: label fontSize * 1.2.
	^ label
	
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> varFor: model [
	^ RSLabel new
		model: model;
		color: self textColor;
		text: model asString;
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
