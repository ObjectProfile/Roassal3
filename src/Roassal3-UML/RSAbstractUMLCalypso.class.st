"
Base class for a calypso tool with uml over classes
"
Class {
	#name : #RSAbstractUMLCalypso,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'classesToShow'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #building }
RSAbstractUMLCalypso >> applyTheme: builder [
	| theme renderer |
	theme := Smalltalk ui theme.
	builder canvas color: theme backgroundColor.
	renderer := builder renderer.
	renderer border color: theme textColor.
	renderer marker shape color: theme backgroundColor.
	renderer textColor: theme textColor.
	renderer boxColor: theme classBoxBackgroundColor.
	builder modelDescriptor methodsLimit: theme methodsLimitUML.
]

{ #category : #building }
RSAbstractUMLCalypso >> build [
	| canvas morph |
	canvas := self buildUmlCanvas.
	morph := canvas createMorph.
	morph onAnnouncement: MorphDeleted 
		do: [ self containerTab owner ifNotNil: [ self containerTab delete]].
	canvas when: RSMouseEnter do: [ morph takeKeyboardFocus].
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #building }
RSAbstractUMLCalypso >> buildUmlCanvas [
	| builder |
	builder := self umlBuilder.
	builder classes: self classesToShow.
	builder canvas @ self canvasController.
	builder build.
	^ builder canvas
]

{ #category : #'public - hooks' }
RSAbstractUMLCalypso >> canvasController [
	| controls |
	controls := RSCanvasController new.
	controls configuration 
		useBasicZoom;
		maxScale: 2.
	^ controls
]

{ #category : #accessing }
RSAbstractUMLCalypso >> classesToShow [
	^ classesToShow ifNil: [ classesToShow := self limitedClasses: self computeClasses ]
]

{ #category : #accessing }
RSAbstractUMLCalypso >> classesToShow: aCollection [
	classesToShow := aCollection
]

{ #category : #accessing }
RSAbstractUMLCalypso >> computeClasses [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractUMLCalypso >> defaultIconName [
	^#hierarchy
]

{ #category : #'private - utilities' }
RSAbstractUMLCalypso >> limitedClasses: aCollection [
	| limit |
	limit := 100.
	^ aCollection size < limit 
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection copyFrom: 1 to: limit ].
]

{ #category : #'public - hooks' }
RSAbstractUMLCalypso >> rebuild: evt [
	| builder |
	evt canvas nodes, evt canvas edges do: #remove.
	RSPopup new removePopupOn: evt.
	builder := RSUMLClassBuilder new.
	builder container: evt canvas.
	self applyTheme: builder.
	builder classes: evt shape model umlClasses.
	builder build.
	builder shapes do: #browseable.
	evt canvas removeKey: #encompassingRectangle.
	evt canvas zoomToFit.
]

{ #category : #building }
RSAbstractUMLCalypso >> umlBuilder [
	| builder |
	builder := RSUMLClassBuilder new.
	builder renderer: RSUMLCalypsoRenderer new.
	builder container: RSCanvas new.
	self applyTheme: builder.
	^ builder
]
