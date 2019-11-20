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
	builder canvas color: theme backgroundColor.
	renderer := builder renderer.
	renderer border color: theme textColor.
	renderer marker shape color: theme backgroundColor.
	renderer textColor: theme textColor.
	renderer boxColor: theme classBoxBackgroundColor.
]

{ #category : #building }
RSUMLCalypso >> build [
	| builder morph controls |
	builder := RSUMLClassBuilder new.
	builder modelDescriptor
		methods: [ :cls | | methods |
			methods := cls methods.
			(methods copyFrom: 1 to: (methods size min: 20)) sorted: CompiledMethod sortBlock ].
	builder container: RSCanvas new.
	controls := RSControlsCanvas new.
	controls configuration 
		useBasicZoom;
		maxScale: 1.
	self applyTheme: builder.
	builder canvas addInteraction: controls.
	builder classes: self classes.
	builder build.
	
	builder canvas createMorph.
	morph := builder canvas morph.
	morph onAnnouncement: MorphDeleted 
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	builder canvas when: RSMouseClick do: [ morph takeKeyboardFocus].
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
