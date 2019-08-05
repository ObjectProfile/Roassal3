"
I am the default renderer that RSUMLClassBuilder 
"
Class {
	#name : #RSBasicUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'classInnerLine'
	],
	#category : #'Roassal3-UML'
}

{ #category : #'accessing - shapes' }
RSBasicUMLClassRenderer >> classInnerLine [
	^ classInnerLine ifNil: [ classInnerLine := RSSingleEdgeBuilder line 
		border: self defaultBorder ].
]

{ #category : #'accessing - shapes' }
RSBasicUMLClassRenderer >> classInnerLine: aShape [
	classInnerLine := aShape
]

{ #category : #initialization }
RSBasicUMLClassRenderer >> initialize [
	super initialize.
	classBoxShape := RSShapeBuilder box
		paint: (Color colorFrom: 'cfd9df');
		cornerRadius: 10;
		border: self defaultBorder
]

{ #category : #initialization }
RSBasicUMLClassRenderer >> initializeShape [
	classShape := RSShapeBuilder composite shapes: [ :cls | 
		| g boxElement title rec line |
		g := self basicGroupOn: cls.
		title := g first.
		boxElement := self classBoxShape elementOn: cls.
		g addFirst: boxElement.
		
		rec := g encompassingRectangle.
		boxElement
			extent: rec extent + self classBoxPadding;
			position: rec rsCenter.
		
		title position: rec rsCenter x @ title position y.
		rec := boxElement encompassingRectangle.
		line := self classInnerLine.
		g size > 2 ifTrue: [ 
			g add: (line
				from: rec origin x @ title height;
				to: rec corner x @ title height;
				edgeOn: nil) ].
		g size > 3 ifTrue: [ 
			g add: (line
				from: rec origin x @ (title height + g third height);
				to: rec corner x @ (title height + g third height);
				edgeOn: nil) ].
		g ];
		interactionDo: [ :i | i popup; draggable; browseable ]
]
