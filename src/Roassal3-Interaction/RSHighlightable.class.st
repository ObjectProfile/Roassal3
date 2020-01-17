"
I a basic interaction to add highlighting events to elements in view.
"
Class {
	#name : #RSHighlightable,
	#superclass : #RSInteraction,
	#instVars : [
		'announcer',
		'attributeKey',
		'copyKey',
		'highlightShapes'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
RSHighlightable class >> defaultRed [
	| inst |
	inst := self new.
	inst highlightColor: Color red.
	^ inst
	
]

{ #category : #announce }
RSHighlightable >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #announce }
RSHighlightable >> announceHighlight: shape source: shapeOrCanvas [
	self announce: [ RSHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #announce }
RSHighlightable >> announceUnHightlight: shape source: shapeOrCanvas [
	self announce: [ RSUnHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #accessing }
RSHighlightable >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ].
]

{ #category : #accessing }
RSHighlightable >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #'accessing - keys' }
RSHighlightable >> attributeKey [
	^ attributeKey ifNil: [ attributeKey := #highlightShapes ].
]

{ #category : #'accessing - keys' }
RSHighlightable >> attributeKey: aSymbol [
	attributeKey := aSymbol.
]

{ #category : #'accessing - keys' }
RSHighlightable >> copyKey [
	^ copyKey ifNil: [ copyKey := #original ].
]

{ #category : #'accessing - keys' }
RSHighlightable >> copyKey: aSymbol [
	copyKey := aSymbol
]

{ #category : #actions }
RSHighlightable >> doHighlight: shape [
	| shapes |
	self unhighlightRecordedShapes: shape.
	shapes := self highlightShapesFor: shape.
	shapes do: [ :e | self announceHighlight: e source: shape ].
	
	shape topParent attributes at: self attributeKey put: shapes.
]

{ #category : #actions }
RSHighlightable >> doHighlightShapes: shapes [
	| allHShapes |
	shapes ifEmpty: [ ^ self ].
	self unhighlightRecordedShapes: shapes first.
	allHShapes := shapes flatCollect: [ :s | | hshapes |
		hshapes := self highlightShapesFor: s.
		hshapes do: [ :hs | self announceHighlight: hs source: s ].
		hshapes ].
	shapes first canvas attributes at: self attributeKey put: allHShapes.
]

{ #category : #actions }
RSHighlightable >> doUnhighlight: aShape [
	self unhighlightRecordedShapes: aShape
]

{ #category : #public }
RSHighlightable >> highlightBorder: aBorder [
	self 
		when: RSHighlightEvent do: [ :evt | self record: evt shape selector: #border value: aBorder ];
		when: RSUnHighlightEvent do: [ :evt | self restore: evt shape selector: #border ].
]

{ #category : #public }
RSHighlightable >> highlightColor: aColor [
	self 
		when: RSHighlightEvent do: [ :evt | self record: evt shape selector: #color value: aColor ];
		when: RSUnHighlightEvent do: [ :evt | self restore: evt shape selector: #color ].
]

{ #category : #accessing }
RSHighlightable >> highlightShapes [
	^ highlightShapes
]

{ #category : #accessing }
RSHighlightable >> highlightShapes: aBlock [
	highlightShapes := aBlock
]

{ #category : #'highlight shapes' }
RSHighlightable >> highlightShapes: aBlock butKeep: aRSHilightable [
	"aBlock recives an element and return a collection of shapes"
	self highlightShapes: [ :e | 
		| shapes |
		shapes := aBlock value: e.
		e canvas attributes
			at: aRSHilightable attributeKey
			ifPresent: [ :hshapes | 
				shapes reject: [ :hs | hshapes includes: hs ] ]
			ifAbsent: [ shapes ] ]
]

{ #category : #'accessing - computed' }
RSHighlightable >> highlightShapesFor: aShape [
	^ highlightShapes rsValue: aShape
]

{ #category : #initialization }
RSHighlightable >> initialize [
	super initialize.
	self highlightShapes: [ :shape | Array with: shape ].

]

{ #category : #public }
RSHighlightable >> lowColor: lowColor highColor: highColor [
	self 
		when: RSHighlightEvent do: [ :evt | evt shape color: highColor  ];
		when: RSUnHighlightEvent do: [ :evt | evt shape color: lowColor ].
	
]

{ #category : #hooks }
RSHighlightable >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ :evt | self doHighlight: evt shape. evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | self doUnhighlight: evt shape. evt signalUpdate ]
]

{ #category : #private }
RSHighlightable >> record: aShape selector: selector value: anObject [
	aShape attributes
		at: self copyKey, selector
		put: (aShape perform: selector).
		
	aShape
		perform: selector, ':' asSymbol 
		with: (anObject rsValue: aShape)
]

{ #category : #actions }
RSHighlightable >> resetHighlightedShapes: shapeOrCanvas [
	| att |
	att := shapeOrCanvas topParent attributes.
	(att includesKey: self attributeKey) ifFalse: [ ^ self ].
	att removeKey: self attributeKey
]

{ #category : #private }
RSHighlightable >> restore: aShape selector: selector [
	| key |
	key := self copyKey, selector.
	aShape attributes
		at: key
		ifPresent: [ :value | 
			aShape 
				perform: selector, ':' asSymbol
				with: value ];
		removeKey: key ifAbsent: [  ].
]

{ #category : #public }
RSHighlightable >> setupAntAnimation [
	self withEdges.
	self when: RSHighlightEvent do: [ :evt | | shape border |
		shape := evt shape.
		border := shape border.
		shape attributeAt: #ob put: border.
		border ifNil: [ border := RSBorder new ].
		shape border: (RSBorder new width: border width * 2; color: border color).
		shape isNode ifTrue: [ 
			| array anime |
			array := #(4).
			shape connectedEdges do: [ :edge | edge border 
				color: Color blue; 
				width: 2;
				dashArray: array. ].
			anime := shape newAnimation
				repeat;
				from: 0;
				to: -8;
				duration: 1 second;
				onStepDo: [ :t |
					shape connectedEdges do: [ :ed |ed border dashOffset: t ].
					shape signalUpdate ].
			shape topParent attributeAt: #antAnimation put: anime.
		].
	].
	self when: RSUnHighlightEvent do: [ :evt | 
		| att shape |
		shape := evt shape.
		shape border: (shape attributeAt: #ob).
		shape removeKey: #ob.
		shape isNode ifTrue: [ 
			att := shape topParent attributes.
			(att at: #antAnimation) stop.
			att removeKey: #antAnimation.
		 ]
	].
]

{ #category : #actions }
RSHighlightable >> unhighlightRecordedShapes: shapeOrCanvas [
	shapeOrCanvas topParent attributes 
		at: self attributeKey 
		ifPresent: [ :shapes |
			shapes do: [ :s | self announceUnHightlight: s source: shapeOrCanvas ].
		 ].
	self resetHighlightedShapes: shapeOrCanvas
]

{ #category : #announcing }
RSHighlightable >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #'highlight shapes' }
RSHighlightable >> withEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s connectedEdges copy.
		list add: s.
		list ].
]

{ #category : #'highlight shapes' }
RSHighlightable >> withIncomingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s incomingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]

{ #category : #'highlight shapes' }
RSHighlightable >> withOutgoingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s outgoingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]
