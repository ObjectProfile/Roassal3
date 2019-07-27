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
		'attributeKey',
		'copyKey'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSHighlightable class >> onElement: element [
	instance ifNil: [ 
		instance := self new.
		instance highlightShape color: Color red.
		 ].
	instance onElement: element.
	^ instance 
]

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
	^ announcer ifNil: [ announcer := Announcer new ].
]

{ #category : #accessing }
RSHighlightable >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
RSHighlightable >> attributeKey [
	^ attributeKey ifNil: [ attributeKey := #highlightElements ].
]

{ #category : #accessing }
RSHighlightable >> attributeKey: aSymbol [
	attributeKey := aSymbol.
]

{ #category : #accessing }
RSHighlightable >> copyKey [
	^ copyKey ifNil: [ copyKey := #original ].
]

{ #category : #accessing }
RSHighlightable >> copyKey: aSymbol [
	copyKey := aSymbol
]

{ #category : #actions }
RSHighlightable >> doHighlight: element [
	| elements |
	self unhighlightRecordedElements: element.
	elements := self highlightElementsFor: element.
	elements do: [ :e | 
		self doHighlightElement: e.
		self announceHighlight: e source: element. ].
	
	element topParent view attributes at: self attributeKey put: elements.
]

{ #category : #'public - hooks' }
RSHighlightable >> doHighlightElement: element [
	self recordIfNecessary: element.
	highlightShape commands ifEmpty: [ ^ self ].
	highlightShape updateElement: element.
]

{ #category : #actions }
RSHighlightable >> doHighlightElements: elements [
	| allHElements |
	elements ifEmpty: [ ^ self ].
	self unhighlightRecordedElements: elements first.
	allHElements := elements flatCollect: [ :e | | helements |
		helements := self highlightElementsFor: e.
		helements do: [ :he | 
			self doHighlightElement: he.
			self announceHighlight: he source: e ].
		helements ].
	
	elements first view attributes at: self attributeKey put: allHElements.
]

{ #category : #actions }
RSHighlightable >> doUnhighlight: anElement [
	self unhighlightRecordedElements: anElement
]

{ #category : #'public - hooks' }
RSHighlightable >> doUnhighlightElement: element [
	| att s originals args |
	att := element attributes.
	(att includesKey: self copyKey) ifFalse: [ ^ self ].
	s := element trachelShape.
	originals := att at: self copyKey.
	args := Array new: 1.
	originals keysAndValuesDo: [ :key :value | 
		args at: 1 put: value.
		s perform: key withArguments: args ].
	att removeKey: self copyKey.
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
	^ element attributes 
		at: self attributeKey
		ifAbsentPut: [ highlightElements rsValue: element ].

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
	^ highlightShape ifNil: [
		self highlightShape: RSShapeBuilder box.
		highlightShape ]
]

{ #category : #accessing }
RSHighlightable >> highlightShape: aShapeBuilder [
	highlightShape := aShapeBuilder.
	highlightShape commands removeAll.
]

{ #category : #initialization }
RSHighlightable >> initialize [
	super initialize.
	self highlightElements: [ :el | Array with: el ].

]

{ #category : #hooks }
RSHighlightable >> onElement: anElement [
	anElement
		when: TSMouseEnter do: [ self doHighlight: anElement. anElement signalUpdate ];
		when: TSMouseLeave do: [ self doUnhighlight: anElement. anElement signalUpdate ]
]

{ #category : #'public - hooks' }
RSHighlightable >> record: element [
	element attributes 
		at: self copyKey 
		put: (self highlightShape currentGetterValues: element)
]

{ #category : #public }
RSHighlightable >> recordElements: elements [
	elements do: [ :e | self record: e ].
]

{ #category : #actions }
RSHighlightable >> recordIfNecessary: element [
	| att |
	att := element attributes.
	(att includesKey: self copyKey) ifTrue: [ ^ self ].
	self record: element.
]

{ #category : #actions }
RSHighlightable >> resetHighlightedElements: anElementOrView [
	| att |
	att := anElementOrView topParent view attributes.
	(att includesKey: self attributeKey) ifFalse: [ ^ self ].
	att removeKey: self attributeKey
]

{ #category : #public }
RSHighlightable >> setupAntAnimation [
	self withEdges.
	self highlightShape
		border: [ TSBorder new width: 2; color: Color red ].
	self when: TSHighlightEvent do: [ :evt | | e |
		(e := evt element) isElement ifTrue: [ 
			| array anime |
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
	].
	self when: TSUnHighlightEvent do: [ :evt | 
		| att e |
		e := evt element.
		e isElement ifTrue: [ 
			att := evt element topParent view attributes.
			(att at: #antAnimation) stop.
			att removeKey: #antAnimation.
		 ]
	].
]

{ #category : #actions }
RSHighlightable >> unhighlightRecordedElements: anElementOrView [
	
	anElementOrView topParent view attributes at: self attributeKey ifPresent: [ :elements |
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
