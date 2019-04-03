"
I am a builder to create UML diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLClassBuilder,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'classes'
	],
	#category : #'Roassal3-UML'
}

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
	self initializeShapes.
]

{ #category : #initialization }
RSUMLClassBuilder >> initializeShapes [
	| box title |
	box := RSShapeBuilder box
		cornerRadius: 5;
		border: TSBorder new.
	title := RSShapeBuilder label.
	shape := RSShapeBuilder composite shapes: [ :m | | g b t |
		g := TSGroup new.
		b := box elementOn: m.
		g add: b.
		t := title elementOn: m.
		g add: t.
		g ].
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: classes).
	RSEdgeBuilder new
		view: aView;
		elements: elements.
		
	RSTreeLayout on: elements.
]
