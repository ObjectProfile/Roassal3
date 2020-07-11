"
I am a basic uml class browser
"
Class {
	#name : #RSUMLClassCalypso,
	#superclass : #RSUMLCalypso,
	#instVars : [
		'targetClass'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #activation }
RSUMLClassCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategy for: ClyClass asCalypsoItemContext
]

{ #category : #accessing }
RSUMLClassCalypso >> classes [
	| clazzes |
	clazzes := targetClass withAllSuperAndSubclasses
		copyWithoutAll: { Object. ProtoObject }.
	^self limitedClasses: clazzes
	
]

{ #category : #initialization }
RSUMLClassCalypso >> defaultTitle [
	^'UML-Class'
]

{ #category : #initialization }
RSUMLClassCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	
	^targetClass  = anotherBrowserTool targetClass
]

{ #category : #initialization }
RSUMLClassCalypso >> setUpModelFromContext [
	super setUpModelFromContext.

	targetClass := context lastSelectedClass
]

{ #category : #accessing }
RSUMLClassCalypso >> targetClass [
	^ targetClass
]
