"
I am a demo class
"
Class {
	#name : #RSDarkUMLClassRenderer,
	#superclass : #RSBasicUMLClassRenderer,
	#instVars : [
		'darkColor'
	],
	#category : #'Roassal3-UML-Examples'
}

{ #category : #initialization }
RSDarkUMLClassRenderer >> initialize [
	super initialize.
	darkColor := Color r: 0.130 g: 0.130 b: 0.130.
	self
		boxColor: darkColor;
		textColor: Color white.
	self marker shape color: darkColor.
	self border
		width: 2;
		color: Color white
]

{ #category : #initialization }
RSDarkUMLClassRenderer >> methodFor: aMethod [
	| s |
	s := super methodFor: aMethod.
	aMethod isOverridden ifTrue: [ s color: Color cyan ].
	^ s
]

{ #category : #initialization }
RSDarkUMLClassRenderer >> setUpCanvas: aCanvas [
	aCanvas color: darkColor
]

{ #category : #initialization }
RSDarkUMLClassRenderer >> titleFor: aClass [
	| shapes |
	shapes := RSGroup with: (super titleFor: aClass).
	aClass hasAbstractMethods ifTrue: [
		shapes addFirst: (RSLabel new
			color: Color magenta;
			italic;
			text: '<<Abstract>>') ].
	self applyLayoutOn: shapes.
	^ RSComposite new
		shapes: shapes;
		yourself
]
