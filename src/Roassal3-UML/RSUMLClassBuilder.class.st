"
I am a builder to create UML diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLClassBuilder,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'classes',
		'classDescriptor',
		'renderer',
		'layout'
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
	renderer := RSUMLClassRenderer new.
	renderer classDescriptor: classDescriptor.
	self initializeShapes.
]

{ #category : #initialization }
RSUMLClassBuilder >> initializeShapes [
	shape := RSShapeBuilder composite
		interactionDo: [ :i | i popup; draggable; browseable ];
		shapes: [ :m | 
			| g boxElement titleLabel rec line |
			g := TSGroup new.
			boxElement := renderer classBoxShape elementOn: m.
			titleLabel := renderer classNameShape elementOn: m.
			g add: titleLabel.
			g add: (renderer varsShape elementOn: m).
			g add: (renderer methodsShape elementOn: m).
			
			RSVerticalLineLayout new gapSize: 0; on: g.
			rec := g encompassingRectangle.
			
			boxElement
				extent: rec extent + 10;
				position: rec rsCenter.
			titleLabel position: rec rsCenter x @ titleLabel position y.
			rec := boxElement encompassingRectangle.
			g addFirst: boxElement.
			line := renderer classInnerLine.
			g add: (line 
				from: rec origin x @ titleLabel height; 
				to: rec corner x @ titleLabel height; edge).
			g add: (line 
				from: rec origin x @ (titleLabel height+ g third height);
				to: rec corner x @ (titleLabel height + g third height); edge ).
			g ];
		onMyselfDo: [ [ :e| | expand collapse button |
			expand := self iconNamed: #overlayAdd.
			collapse := self iconNamed: #overlayRemove.
			button := RSShapeBuilder bitmap
				form: collapse;
				size: 20;
				element.
			button when: TSMouseClick do: [ 
				button form: (button form = expand 
					ifTrue: [ collapse ]
					ifFalse: [ expand ]).
				button signalUpdate. ].
			RSLocate new border top; right;
				stick: button on: e shapes first.
			e add: button trachelShape.
			] ].
		
	

]

{ #category : #accessing }
RSUMLClassBuilder >> layout [ 
	^ layout ifNil: [ layout := RSLayoutBuilder new.
		layout tree verticalGap: 100; horizontalGap: 50.
		layout ]
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: classes).
	self renderer edgeBuilder
		view: aView;
		objects: classes;
		connectFrom: classDescriptor superclass.
	self layout on: elements.
]

{ #category : #accessing }
RSUMLClassBuilder >> renderer [
	^ renderer
]

{ #category : #accessing }
RSUMLClassBuilder >> view [
	^ view ifNil: [ 
		view := RSView new.
		view @ RSControlsView.
		view ]
]
