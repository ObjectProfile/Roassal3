"
I am an abstract browser for uml classes and packages in calypso
"
Class {
	#name : #RSUMLCalypso,
	#superclass : #ClyBrowserToolMorph,
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #initialization }
RSUMLCalypso >> activationPriority [
	^0
]

{ #category : #building }
RSUMLCalypso >> applyTheme: builder [
	| theme renderer |
	theme := Smalltalk ui theme.
	builder view color: theme backgroundColor.
	renderer := builder renderer.
	renderer border color: theme textColor.
	renderer marker shape color: theme backgroundColor.
	renderer classNameShape color: theme textColor.
	renderer varShape color: theme textColor.
	renderer methodShape color: theme textColor.
	renderer classBoxShape color: theme classBoxBackgroundColor.
]

{ #category : #building }
RSUMLCalypso >> build [
	| builder morph controls |
	builder := RSUMLClassBuilder new.
	builder view: RSView new.
	controls := RSControlsView new.
	controls configuration 
		useBasicZoom;
		maxScale: 1.
	self applyTheme: builder.
	builder renderer methodShape
		interactionDo: [ :i | i popup multiline ].
	builder view addInteraction: controls.
	builder classes: self classes.
	builder build.

	builder view createMorph.
	morph := builder view morph.
	morph onAnnouncement: MorphDeleted 
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	builder view when: TSMouseClick do: [ morph takeKeyboardFocus].
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #accessing }
RSUMLCalypso >> classes [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSUMLCalypso >> defaultIconName [
	^#hierarchy
]

{ #category : #initialization }
RSUMLCalypso >> tabOrder [
	^ 200
]
