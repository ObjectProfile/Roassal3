"
I am a builder to create UML diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLClassBuilder,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'classes',
		'classDescriptor'
	],
	#category : #'Roassal3-UML'
}

{ #category : #accessing }
RSUMLClassBuilder >> classDescriptor [
	^ classDescriptor
]

{ #category : #accessing }
RSUMLClassBuilder >> classes [
	^ classes
]

{ #category : #accessing }
RSUMLClassBuilder >> classes: aColletionOfClasses [
	classes := aColletionOfClasses 
]

{ #category : #initialization }
RSUMLClassBuilder >> initialize [
	super initialize.
	classDescriptor := RSUMLClassDescriptor new.
	self initializeShapes.
]

{ #category : #initialization }
RSUMLClassBuilder >> initializeShapes [
	| box title varsShape varShape methodsShape methodShape border line |
	border := TSBorder new.
	box := RSShapeBuilder box
		paint: Color white;
		cornerRadius: 5;
		border: border.
	line := RSSingleEdgeBuilder line.
	title := RSShapeBuilder label 
		fontSize: 20;
		text: [ :m | classDescriptor classname rsValue: m ].
	varShape := RSShapeBuilder label fontSize: 12.
	varsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := varShape elementsOn: (classDescriptor instVars rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ].
	methodShape := RSShapeBuilder label 
		fontSize: 12;
		text: [:m | classDescriptor methodSelector rsValue: m ].
	methodsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := methodShape elementsOn: (classDescriptor methods rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ].
	shape := RSShapeBuilder composite
		interactionDo: [ :i | i popup; draggable; browseable ];
		shapes: [ :m | 
			| g boxElement titleLabel rec |
			g := TSGroup new.
			boxElement := box elementOn: m.
			
			titleLabel := title elementOn: m.
			g add: titleLabel.
			
			g add: (varsShape elementOn: m).
			g add: (methodsShape elementOn: m).
			RSVerticalLineLayout new gapSize: 0; on: g.
			rec := g encompassingRectangle.
			
			boxElement
				extent: rec extent + 10;
				position: rec rsCenter;
				paint: (TSGradientPalette heavyRain 
					start: rec origin; 
					stop: rec corner).
			titleLabel position: rec rsCenter x @ titleLabel position y.
			rec := boxElement encompassingRectangle.
			g addFirst: boxElement.
			g add: (line 
				from: rec origin x @ titleLabel height; 
				to: rec corner x @ titleLabel height; edge).
			g add: (line 
				from: rec origin x @ (titleLabel height+ g third height);
				to: rec corner x @ (titleLabel height + g third height); edge ).
			g ]
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aView [
	| marker |
	aView addAll: (elements := shape elementsOn: classes).
	marker := TSMarker new 
		offset: 25 / 2;
		shape: (RSShapeBuilder triangle
			color: Color white;
			border: (TSBorder new);
			extent: 20@25) element.
	RSEdgeBuilder orthoVertical
		attachPoint: RSVerticalAttachPoint new; 
		markerStart: marker;
		view: aView;
		objects: classes;
		connectFrom: #superclass.
		
	RSTreeLayout new verticalGap: 100; horizontalGap: 50; on: elements.
]

{ #category : #accessing }
RSUMLClassBuilder >> view [
	^ view ifNil: [ 
		view := RSView new.
		view @ RSControlsView.
		view ]
]
