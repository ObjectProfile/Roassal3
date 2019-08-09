"
I am the default renderer that RSUMLClassBuilder 
"
Class {
	#name : #RSBasicUMLClassRenderer,
	#superclass : #RSAbstractUMLClassRenderer,
	#instVars : [
		'classInnerLine'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #'accessing - shapes' }
RSBasicUMLClassRenderer >> classInnerLine [
	^ classInnerLine ifNil: [
		classInnerLine := RSSingleEdgeBuilder line
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
	classBoxShape := RSShapeBuilder box
		paint: (Color colorFrom: 'cfd9df');
		cornerRadius: 10;
		border: self border
]

{ #category : #'private - initialization' }
RSBasicUMLClassRenderer >> initializeShape [
	classShape := RSShapeBuilder composite shapes: [ :cls | 
		| group boxElement title rec line |
		group := self initBasicGroupOn: cls.
		title := group first.
	 
		boxElement := self classBoxShape elementOn: cls.
		group addFirst: boxElement.
		
		
		rec := group encompassingRectangle.
		boxElement
			extent: rec extent + self classBoxPadding;
			position: rec rsCenter.
		
		title position: rec rsCenter x @ title position y.
		rec := boxElement encompassingRectangle.
		line := self classInnerLine.
		group size > 2 ifTrue: [ 
			group add: (line
				from: rec origin x @ title height;
				to: rec corner x @ title height;
				edgeOn: nil) ].
		group size > 4 ifTrue: [ 
			group add: (line
				from: rec origin x @ (title height + group third height);
				to: rec corner x @ (title height + group third height);
				edgeOn: nil) ].
		group ];
		interactionDo: [ :i | i popup; draggable; browseable ]
]
