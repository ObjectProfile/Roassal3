"
Specific renderer for calypso
"
Class {
	#name : #RSUMLCalypsoRenderer,
	#superclass : #RSBasicUMLClassRenderer,
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #hooks }
RSUMLCalypsoRenderer >> classBoxShapeFor: aClass [ 
	| box alpha |
	box := super classBoxShapeFor: aClass.
	alpha := 0.3.
	aClass isTestCase ifTrue: [ 
		aClass hasPassedTest ifTrue: [ box color: Color green ].
		aClass hasFailedTest ifTrue: [ box color: Color yellow ].
		aClass hasErrorTest ifTrue: [ box color: Color red ].
		box color: (box color alpha: alpha).
		 ].
	^ box
]

{ #category : #hooks }
RSUMLCalypsoRenderer >> methodFor: method [
	| label icon com |
	label := super methodFor: method.
	method isTestMethod ifFalse: [ ^ label ].
	icon := RSEllipse new size: label fontSize.
	method isPassedTest ifTrue: [ icon color: Color green ].
	method isFailedTest ifTrue: [ icon color: Color yellow ].
	method isErrorTest ifTrue: [ icon color: Color red ].
	com := RSComposite new
		add: icon; 
		add: label;
		yourself.	
	RSHorizontalLineLayout new 
		alignMiddle; 
		gapSize: label fontSize / 3; 
		on: com children.
	com adjustToChildren.
	^ com
]
