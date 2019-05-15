"
I am a basic browser with roassal and calypso
"
Class {
	#name : #RSUmlCalypso,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'targetClass'
	],
	#category : #'Roassal3-UML'
}

{ #category : #activation }
RSUmlCalypso class >> classUmlTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategy for: ClyClass asCalypsoItemContext
]

{ #category : #initialization }
RSUmlCalypso >> activationPriority [
	^0
]

{ #category : #building }
RSUmlCalypso >> build [
	| builder morph |
	builder := RSUMLClassBuilder new.
	builder classes: self targetClass withAllSubclasses.
	builder build.
	builder view createMorph.
	morph := builder view morph.
	morph onAnnouncement: MorphDeleted 
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	builder view when: TSMouseClick do: [ morph takeKeyboardFocus].
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #initialization }
RSUmlCalypso >> defaultIconName [
	^#hierarchy
]

{ #category : #initialization }
RSUmlCalypso >> defaultTitle [
	^'UML'
]

{ #category : #initialization }
RSUmlCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	
	^targetClass  = anotherBrowserTool targetClass
]

{ #category : #initialization }
RSUmlCalypso >> setUpModelFromContext [
	super setUpModelFromContext.

	targetClass := context lastSelectedClass
]

{ #category : #initialization }
RSUmlCalypso >> tabOrder [
	^ 200
]

{ #category : #initialization }
RSUmlCalypso >> targetClass [
	^ targetClass
]
