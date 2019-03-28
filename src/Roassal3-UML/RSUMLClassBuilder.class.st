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
	shape := RSShapeBuilder box.
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: classes).
	RSEdgeBuilder new
		view: aView;
		elements: elements.
		
	RSTreeLayout on: elements.
]
