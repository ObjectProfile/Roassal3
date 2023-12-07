"
Base class for a calypso tool with uml over classes
"
Class {
	#name : 'RSAbstractUMLCalypso',
	#superclass : 'ClyBrowserToolMorph',
	#instVars : [
		'classesToShow'
	],
	#category : 'Roassal-UML-Calypso-Core',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Core'
}

{ #category : 'building' }
RSAbstractUMLCalypso >> addClassInteractions: builder [

	builder canvas nodes
		when: RSMouseDoubleClick
		do: [ :evt | evt shape model browse ]
		for: self;
		when: RSMouseRightClick do: [ :evt |
			| menu newContext tool |
			tool := ClyFullBrowserMorph on:
					        ClyNavigationEnvironment currentImage.
			tool prepareInitialStateBy: [ :b | b selectClass: evt shape model ].
			"newContext := ClyFullBrowserClassContext for: tool."
			newContext := context copy.
			newContext tool: tool.
			menu := CmdContextMenuActivation
				        buildContextMenuFor: evt canvas morph
				        inContext: newContext.
			menu popUpInWorld: self currentWorld ]
		for: self
]

{ #category : 'building' }
RSAbstractUMLCalypso >> applyTheme: builder [
	| theme renderer |
	theme := self theme.
	builder canvas color: theme backgroundColor.
	renderer := builder renderer.
	renderer border color: theme textColor.
	renderer marker shape color: theme backgroundColor.
	renderer textColor: theme textColor.
	renderer boxColor: theme classBoxBackgroundColor.
	builder modelDescriptor methodsLimit: theme methodsLimitUML
]

{ #category : 'building' }
RSAbstractUMLCalypso >> build [

	| canvas morph |
	canvas := self buildUmlCanvas.
	morph := canvas createMorph.
	morph
		onAnnouncement: MorphDeleted
		do: [
		self containerTab owner ifNotNil: [ self containerTab delete ] ].
	canvas when: RSMouseEnter do: [ morph takeKeyboardFocus ] for: self.
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : 'building' }
RSAbstractUMLCalypso >> buildUmlCanvas [
	| builder |
	builder := self umlBuilder.
	builder classes: self classesToShow.
	builder canvas @ self canvasController.
	builder build.
	self addClassInteractions: builder.

	^ builder canvas
]

{ #category : 'public - hooks' }
RSAbstractUMLCalypso >> canvasController [
	| controls |
	controls := RSCanvasController new.
	controls configuration
		useBasicZoom;
		maxScale: 2.
	^ controls
]

{ #category : 'accessing' }
RSAbstractUMLCalypso >> classesToShow [
	^ classesToShow ifNil: [ classesToShow := self limitedClasses: self computeClasses ]
]

{ #category : 'accessing' }
RSAbstractUMLCalypso >> classesToShow: aCollection [
	classesToShow := aCollection
]

{ #category : 'accessing' }
RSAbstractUMLCalypso >> computeClasses [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
RSAbstractUMLCalypso >> defaultIconName [
	^#hierarchy
]

{ #category : 'private - utilities' }
RSAbstractUMLCalypso >> limitedClasses: aCollection [
	| limit |
	limit := 100.
	^ aCollection size < limit
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection copyFrom: 1 to: limit ]
]

{ #category : 'building' }
RSAbstractUMLCalypso >> umlBuilder [
	| builder |
	builder := RSUMLClassBuilder new.
	builder renderer: RSUMLCalypsoRenderer new.
	builder container: RSCanvas new.
	self applyTheme: builder.
	^ builder
]
