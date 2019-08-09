"
I am a builder to create UML diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLClassBuilder,
	#superclass : #RSUMLAbstractBuilder,
	#instVars : [
		'classes'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #accessing }
RSUMLClassBuilder >> classes [
	^ classes
]

{ #category : #accessing }
RSUMLClassBuilder >> classes: aColletionOfClasses [
	classes := aColletionOfClasses 
]

{ #category : #'button behavior' }
RSUMLClassBuilder >> collapse: e [
	| shapes title box extent button |
	shapes := e shapes copy.
	box := e shapes first.
	title := shapes second.
	button := shapes last.
	title position: box position.
	
	extent := title extent + 5.
	box extent: extent.
	RSLocation new border top; left; move: button on: box.
	e extent: extent; translateTo: e position.
	shapes := e shapes copy.
	3 to: e shapes size do: [ :i | (shapes at: i) remove ].
]

{ #category : #'button behavior' }
RSUMLClassBuilder >> createButtonOn: e [
	| expand collapse button |
	expand := self iconNamed: #overlayAdd.
	collapse := self iconNamed: #overlayRemove.
	button := RSShapeBuilder bitmap
		form: collapse;
		size: 20;
		element.
	button when: TSMouseClick do: [ 
		button form: (button form = expand
			ifTrue: [ self expand: e. collapse ]
			ifFalse: [ self collapse: e. expand ]).
		e signalUpdate ].
	RSLocation new border top; left; move: button on: e shapes first.
	^ button shape
]

{ #category : #initialization }
RSUMLClassBuilder >> createShapesFor: cls [
	| g boxElement titleLabel rec line |
	g := TSGroup new.
	boxElement := renderer classBoxShape elementOn: cls.
	titleLabel := renderer classNameShape elementOn: cls.
	g add: titleLabel.
	g add: (renderer varsShape elementOn: cls).
	g add: (renderer methodsShape elementOn: cls).
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
		to: rec corner x @ titleLabel height;
		edge).
	g add: (line
		from: rec origin x @ (titleLabel height + g third height);
		to: rec corner x @ (titleLabel height + g third height);
		edge).
	^ g
]

{ #category : #defaults }
RSUMLClassBuilder >> defaultLayout [

	| defaultLayout |
	defaultLayout := RSLayoutBuilder new.
	defaultLayout tree 
		verticalGap: 100; 
		horizontalGap: 50.
	^defaultLayout
]

{ #category : #'button behavior' }
RSUMLClassBuilder >> expand: e [
	| shapes att positions extent |
	att := e attributes.
	shapes := att at: #shapes.
	positions := att at: #positions.
	extent := att at: #extent.
	shapes last remove.
	3 to: shapes size do: [ :i | 
		e add: (shapes at: i )].
	shapes doWithIndex: [ :s :i | s translateTo: (positions at: i) ].
	
	shapes first extent: extent.
	e extent: extent; translateTo: e position.
]

{ #category : #initialization }
RSUMLClassBuilder >> initialize [
	super initialize.
	self
		modelDescriptor: RSUMLClassDescriptor new;
		renderer: RSBasicUMLClassRenderer new
]

{ #category : #initialization }
RSUMLClassBuilder >> initializeShape [
	shape := renderer classShape.
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: classes).
	self renderer edgeBuilder
		view: aView;
		objects: classes;
		connectFrom: modelDescriptor superclass.
	self layout on: elements.
]
