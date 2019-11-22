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

{ #category : #initialization }
RSUMLClassBuilder >> initialize [
	super initialize.
	self
		modelDescriptor: RSUMLClassDescriptor new;
		renderer: RSBasicUMLClassRenderer new
]

{ #category : #hooks }
RSUMLClassBuilder >> renderIn: aCanvas [
	| classShapes |
	classShapes := self renderer shapesFor: classes.
	aCanvas addAll: classShapes.
	shapes addAll: classShapes.
	self renderer edgeBuilder
		canvas: aCanvas;
		shapes: classShapes;
		connectFrom: modelDescriptor superclass.
	self layout on: classShapes.
	renderer setUpCanvas: aCanvas.

]
