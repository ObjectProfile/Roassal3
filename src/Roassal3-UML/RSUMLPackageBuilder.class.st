"
I am a builder to create UML package diagrams in Roassal3, see examples
"
Class {
	#name : #RSUMLPackageBuilder,
	#superclass : #RSUMLAbstractBuilder,
	#instVars : [
		'packages'
	],
	#category : #'Roassal3-UML-Builder'
}

{ #category : #defaults }
RSUMLPackageBuilder >> defaultLayout [

	| defaultLayout |
	defaultLayout := TSLayoutBuilder new.
	defaultLayout vertical 
		verticalGap: 100; 
		horizontalGap: 50.
	^defaultLayout
]

{ #category : #initialization }
RSUMLPackageBuilder >> initialize [
	super initialize.
	self
		modelDescriptor: RSUMLPackageDescriptor new;
		renderer: RSBasicUMLPackageRenderer new
]

{ #category : #initialization }
RSUMLPackageBuilder >> initializeShape [
	shape := renderer packageShape.
]

{ #category : #accessing }
RSUMLPackageBuilder >> packages [ 

	^packages 
]

{ #category : #accessing }
RSUMLPackageBuilder >> packages: aCollection [

	packages := aCollection
]

{ #category : #hooks }
RSUMLPackageBuilder >> renderIn: aView [
	aView addAll: (elements := shape elementsOn: packages).
	"self renderer edgeBuilder
		view: aView;
		objects: packages;
		connectFrom: modelDescriptor superclass."
	self layout on: elements.
]
