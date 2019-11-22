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
	shapes first view attributes at: self attributeKey put: allHShapes.
]

{ #category : #actions }
RSHighlightable >> doUnhighlight: aShape [
	self unhighlightRecordedShapes: aShape
]

{ #category : #public }
RSHighlightable >> highlightColor: aColor [
	self 
		when: RSHighlightEvent do: [ :evt | self record: evt shape color: aColor ];
		when: RSUnHighlightEvent do: [ :evt | self restoreColor: evt shape ].
	
]

{ #category : #'highlight elements' }
RSHighlightable >> highlightElements: aBlock butKeep: aRSHilightable [
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

{ #category : #accessing }
RSHighlightable >> highlightShapes [
	^ highlightShapes
]

{ #category : #accessing }
RSHighlightable >> highlightShapes: aBlock [
	highlightShapes := aBlock
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
RSHighlightable >> low: aColorA high: aColorB [
	self 
		when: RSHighlightEvent do: [ :evt | evt shape color: aColorB  ];
		when: RSUnHighlightEvent do: [ :evt | evt shape color: aColorA ].
	
]

{ #category : #hooks }
RSHighlightable >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ self doHighlight: aShape. aShape signalUpdate ];
		when: RSMouseLeave do: [ self doUnhighlight: aShape. aShape signalUpdate ]
]

{ #category : #private }
RSHighlightable >> record: aShape color: aColor [
	self record: aShape key: #color value: aShape color.
	aShape color: aColor
]

{ #category : #private }
RSHighlightable >> record: aShape key: key value: aValue [
	aShape attributes
		at: self copyKey, key
		put: aValue
]

{ #category : #actions }
RSHighlightable >> resetHighlightedShapes: shapeOrCanvas [
	| att |
	att := shapeOrCanvas topParent attributes.
	(att includesKey: self attributeKey) ifFalse: [ ^ self ].
	att removeKey: self attributeKey
]

{ #category : #private }
RSHighlightable >> restoreColor: aShape [
	aShape attributes
		at: self copyKey, #color
		ifPresent: [ :color | aShape color: color ]
]

{ #category : #public }
RSHighlightable >> setupAntAnimation [
	self withEdges.

	self when: RSHighlightEvent do: [ :evt | | shape |
		shape := evt shape.
		shape attributeAt: #ob put: shape border.
		shape border: (RSBorder new width: 2; color: Color red).
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

{ #category : #'highlight elements' }
RSHighlightable >> withEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s connectedEdges copy.
		list add: s.
		list ].
]

{ #category : #'highlight elements' }
RSHighlightable >> withIncomingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s incomingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]

{ #category : #'highlight elements' }
RSHighlightable >> withOutgoingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s outgoingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]
