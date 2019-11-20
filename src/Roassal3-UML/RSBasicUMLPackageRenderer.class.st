"
A basic renderer for UML packages
"
Class {
	#name : #RSBasicUMLPackageRenderer,
	#superclass : #RSAbstractUMLPackageRenderer,
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #hooks }
RSBasicUMLPackageRenderer >> shapeFor: aPackage [
	| title classes box |
	title := self packageNameFor: aPackage.
	classes := self classesFor: aPackage.
	box := self packageBoxFor: title and: classes.
	^ RSComposite new
		model: aPackage;
		shapes: { box. title. classes };
		popup;
		browseable;
		draggable;
		yourself
]
