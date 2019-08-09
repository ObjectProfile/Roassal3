"
I have the roassal shapes to build the visualizacion
"
Class {
	#name : #RSAbstractUMLClassRenderer,
	#superclass : #RSAbstractUMLRenderer,
	#instVars : [
		'marker',
		'edgeBuilder',
		'classBoxShape',
		'classNameShape',
		'methodsShape',
		'methodShape',
		'varsShape',
		'varShape',
		'classShape',
		'padding'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLClassRenderer class >> isAbstract [ 

	^self name = #RSAbstractUMLClassRenderer 
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> classBoxPadding [
	^ padding ifNil: [ padding := 10@10 ]
]

{ #category : #accessing }
RSAbstractUMLClassRenderer >> classBoxPadding: aPoint [
	padding := aPoint
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classBoxShape [
	^ classBoxShape
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classBoxShape: aRSShapeBuilder [ 
	classBoxShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classNameShape [
	^ classNameShape ifNil: [ classNameShape := RSShapeBuilder label
		text: [ :m | modelDescriptor classname rsValue: m ];
		onElement;
		fontSize: [ :e | e font pointSize * 1.2];
		onModel ]
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classNameShape: aRSShapeBuilder [
	classNameShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classShape [
	^ classShape
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> classShape: aRSShapeBuilder [
	classShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> edgeBuilder [
	^ edgeBuilder ifNil: [ edgeBuilder := RSEdgeBuilder orthoVertical
		attachPoint: RSVerticalAttachPoint new; 
		border: self defaultBorder;
		markerStart: self marker ]
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> edgeBuilder: anEdgeBuilder [
	edgeBuilder := anEdgeBuilder
]

{ #category : #'private - initialization' }
RSAbstractUMLClassRenderer >> initBasicGroupOn: cls [
	| group vars methods |
	group := TSGroup new.
	group add: (self classNameShape elementOn: cls).
	vars := self varsShape elementOn: cls.
	methods := self methodsShape elementOn: cls.
	vars hasChildren 
		ifTrue: [ group add: vars ].
	methods hasChildren
		ifTrue: [ group add: methods ].
	
	RSVerticalLineLayout new gapSize: 0; on: group.
	^ group 
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> marker [ 
	^ marker ifNil: [ marker := TSMarker new 
		offset: 10;
		shape: (RSShapeBuilder triangle
			color: Color white;
			border: self defaultBorder;
			size: 20) element ]
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> marker: aMarker [
	marker := aMarker.
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> methodShape [ 
	^ methodShape ifNil: [ methodShape := RSShapeBuilder label 
		text: [:m | modelDescriptor methodSelector rsValue: m ] ]
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> methodShape: aRSShapeBuilder [
	methodShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> methodsShape [ 
	^ methodsShape ifNil: [ methodsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self methodShape elementsOn: (modelDescriptor methods rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ] ]
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> methodsShape: aRSShapeBuilder [
	methodsShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> varShape [
	^ varShape ifNil: [ varShape := RSShapeBuilder label ].
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> varShape: aRSShapeBuilder [
	varShape := aRSShapeBuilder
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> varsShape [
	^ varsShape ifNil: [ varsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self varShape elementsOn: (modelDescriptor instVars rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ] ].
]

{ #category : #'accessing - shapes' }
RSAbstractUMLClassRenderer >> varsShape: aRSShapeBuilder [
	varsShape := aRSShapeBuilder
]
