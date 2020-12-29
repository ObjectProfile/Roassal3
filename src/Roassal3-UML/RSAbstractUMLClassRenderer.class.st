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

{ #category : #accessing }
RSAbstractUMLClassRenderer >> aggregationShape [
	| shape |
	shape := self compositionShape.
	
	shape markerEnd shape color: Color white.
	^ shape
]

{ #category : #layout }
RSAbstractUMLClassRenderer >> applyLayoutOn: shapes [
	RSVerticalLineLayout new gapSize: 1.5; on: shapes.
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

{ #category : #accessing }
RSAbstractUMLClassRenderer >> compositionShape [
	| m |
	m := RSShapeFactory diamond extent: 10@15.
	m border: self border; color: self border color.
	m := m asMarker.
	m offset: 15 / 2.0.
	^ RSLine new
		markerEnd: m;
		border: self border;
		yourself.
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> createEllipsisIfNecessaryOn: aGroup [
	| rect ellipsis |
	self needsEllipsis ifFalse: [ ^ self ].
	
	ellipsis := self ellipsisShape.
	rect := aGroup encompassingRectangle.
	ellipsis position: rect bottomCenter + (0@10).
	aGroup add: ellipsis.
	
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultClassBoxPadding [
	^ 10@10
]

{ #category : #defaults }
RSAbstractUMLClassRenderer >> defaultEdgeBuilder [
	| offset |
	offset := -2.5.
	^ RSLineBuilder orthoVertical
		attachPoint: (RSVerticalAttachPoint new 
			startOffset: 11 - offset;
			endOffset: offset;
			yourself);
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

{ #category : #public }
RSAbstractUMLClassRenderer >> renderAssociation: aCollection shape: aRSLine [ 
	aCollection ifNil: [ ^ self ].
	(RSLineBuilder new: aRSLine)
		withBorderAttachPoint;
		shapes: edgeBuilder fromShapes;
		useAssociations: aCollection.
]

{ #category : #public }
RSAbstractUMLClassRenderer >> renderAssociations [
	self renderAssociation: self modelDescriptor compositions shape: self compositionShape.
	self renderAssociation: self modelDescriptor aggregations shape: self aggregationShape.
	
]

{ #category : #hooks }
RSAbstractUMLClassRenderer >> titleFor: model [
	| label |
	label := RSLabel new
		color: self textColor;
		text: (modelDescriptor classname rsValue: model);
		yourself.
	label fontSize: label fontSize.
	^ { label } asGroup asShape padding: 0@ 5; yourself
	
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
		padding: (Margin left: 0 right: 0 top: 3  bottom: 8 );
		yourself
		
]
