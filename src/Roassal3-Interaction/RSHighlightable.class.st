"
I a basic interaction to add highlighting events to elements in view.
"
Class {
	#name : #RSHighlightable,
	#superclass : #RSInteraction,
	#instVars : [
		'highlightElements',
		'highlightShape',
		'announcer',
		'attributeKey'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #announce }
RSHighlightable >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #announce }
RSHighlightable >> announceHighlight: element source: anElementOrView [
	self announce: [ TSHighlightEvent new
		interaction: self;
		element: element;
		source: anElementOrView ].
]

{ #category : #announce }
RSHighlightable >> announceUnHightlight: element source: anElementOrView [
	self announce: [ TSUnHighlightEvent new
		interaction: self;
		element: element;
		source: anElementOrView ].
]

{ #category : #accessing }
RSHighlightable >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #accessing }
RSHighlightable >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
RSHighlightable >> attributeKey: aSymbol [
	attributeKey := aSymbol.
]

{ #category : #initialization }
RSHighlightable >> defaultColor [
	^ Color red
]

{ #category : #actions }
RSHighlightable >> doHighlight: element [
	| elements |
	self unhighlightRecordedElements: element.
	elements := self highlightElementsFor: element.
	elements do: [ :e | 
		self doHighlightElement: e.
		self announceHighlight: e source: element. ].
	
	element topParent view attributes at: self key put: elements.
]

{ #category : #'public - hooks' }
RSHighlightable >> doHighlightElement: element [
	self recordIfNecessary: element.
	highlightShape updateElement: element.
]

{ #category : #actions }
RSHighlightable >> doHighlightElements: elements [
	| allHElements |
	elements ifEmpty: [ ^ self ].
	self unhighlightRecordedElements: elements first.
	allHElements := elements flatCollect: [ :e | | helements |
		helements := self highlightElementsFor: e.
		helements do: [ :he | self doHighlightElement: he ].
		helements ].
	
	elements first view attributes at: self key put: allHElements.
]

{ #category : #actions }
RSHighlightable >> doUnhighlight: anElement [
	self unhighlightRecordedElements: anElement
]

{ #category : #'public - hooks' }
RSHighlightable >> doUnhighlightElement: element [
	| att s originals args |
	att := element attributes.
	(att includesKey: #original) ifFalse: [ ^ self ].
	s := element trachelShape.
	originals := att at: #original.
	args := Array new: 1.
	originals do: [ :ab | 
		args at: 1 put: ab value.
		s perform: ab key withArguments: args ].
	att removeKey: #original.
]

{ #category : #accessing }
RSHighlightable >> highlightElements [
	^ highlightElements
]

{ #category : #accessing }
RSHighlightable >> highlightElements: aBlock [
	highlightElements := aBlock
]

{ #category : #'accessing - computed' }
RSHighlightable >> highlightElementsFor: element [
	^ element attributes at: self key ifAbsentPut: [ 
		highlightElements rsValue: element ].

]

{ #category : #accessing }
RSHighlightable >> highlightShape [
	"
	Gives a highlight shape. Useful to change the color of the highlight. 

For example
-=-=-=
v := RSView new.

sb := RSShapeBuilder box
			elementsOn: (1 to: 100).
v addAll: sb.

highlight := RSHighlightable new.
highlight highlightShape color: Color red trans.
sb @ highlight.
RSGridLayout on: sb.
v @ RSControlsView.
v open			
-=-=-=
	"
	^ highlightShape ifNil: [ self highlightShape: RSShapeBuilder box.
		highlightShape color: self defaultColor.
		highlightShape ]
]

{ #category : #accessing }
RSHighlightable >> highlightShape: aShapeBuilder [
	highlightShape := aShapeBuilder.
	highlightShape 
		commands: OrderedCollection new.
]

{ #category : #initialization }
RSHighlightable >> initialize [
	super initialize.
	self highlightElements: [ :el | Array with: el ].

]

{ #category : #accessing }
RSHighlightable >> key [
	^ attributeKey ifNil: [ attributeKey := #highlightElements ].
]

{ #category : #public }
RSHighlightable >> noDefaultColor [
	self highlightShape removeCommandsBySelector: #color:
]

{ #category : #hooks }
RSHighlightable >> onElement: anElement [
	anElement
		when: TSMouseEnter do: [ self doHighlight: anElement. anElement signalUpdate ];
		when: TSMouseLeave do: [ self doUnhighlight: anElement. anElement signalUpdate ]
]

{ #category : #'public - hooks' }
RSHighlightable >> record: element [
	| originals |
	originals := self highlightShape commands collect: [ :cmd |
		| sel |
		sel := cmd selector.
		sel -> (element perform: sel allButLast asSymbol)  ].
	element attributes at: #original put: originals
]

{ #category : #public }
RSHighlightable >> recordElements: elements [
	elements do: [ :e | self record: e ].
]

{ #category : #actions }
RSHighlightable >> recordIfNecessary: element [
	| att |
	att := element attributes.
	(att includesKey: #original) ifTrue: [ ^ self ].
	self record: element.
]

{ #category : #actions }
RSHighlightable >> resetHighlightedElements: anElementOrView [
	| att |
	att := anElementOrView topParent view attributes.
	(att includesKey: self key) ifFalse: [ ^ self ].
	att removeKey: self key
]

{ #category : #public }
RSHighlightable >> setupAntAnimation [
	self noDefaultColor withEdges.
	self highlightShape
		border: [ TSBorder new width: 2; color: self defaultColor ].
	self when: TSHighlightEvent do: [ :evt | 
		| e array anime |
		e := evt element.
		array := #(4).
		e connectedEdges do: [ :ed| ed border 
			color: Color blue; 
			width: 2;
			dashArray: array. ].
		anime := e newAnimation
			repeat;
			from: 0;
			to: -8;
			duration: 1 second;
			onStepDo: [ :t |
				e connectedEdges do: [ :ed |ed border dashOffset: t ].
				e signalUpdate ].
		e topParent view attributes at: #antAnimation put: anime.
	].
	self when: TSUnHighlightEvent do: [ :evt | 
		| att |
		att := evt element topParent view attributes.
		(att at: #antAnimation) stop.
		att removeKey: #antAnimation.
	].
]

{ #category : #actions }
RSHighlightable >> unhighlightRecordedElements: anElementOrView [
	
	anElementOrView topParent view attributes at: self key ifPresent: [ :elements |
		elements do: [ :e | 
			self doUnhighlightElement: e.
			self announceUnHightlight: e source: anElementOrView.
			 ].
		 ].
	self resetHighlightedElements: anElementOrView
]

{ #category : #announcing }
RSHighlightable >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #public }
RSHighlightable >> withEdges [
	self highlightElements: [ :e | e connectedEdges copy add: e; yourself ].
]

{ #category : #public }
RSHighlightable >> withIncomingEdges [
	self highlightElements: [ :e | e incomingEdges copy asOrderedCollection add: e; yourself ].
]

{ #category : #public }
RSHighlightable >> withOutgoingEdges [
	self highlightElements: [ :e | e outgoingEdges copy asOrderedCollection add: e; yourself ].
]
