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

{ #category : #initialization }
RSUMLPackageBuilder >> initialize [
	super initialize.
	self
		modelDescriptor: RSUMLPackageDescriptor new;
		renderer: RSBasicUMLPackageRenderer new
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
RSUMLPackageBuilder >> renderIn: aCanvas [
	aCanvas addAll: (shapes := self renderer shapesFor: self packages).
	self layout on: shapes.
]
