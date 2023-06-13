Class {
	#name : #RSSelectionInCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'elastic',
		'shadowInteraction'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #examples }
RSSelectionInCanvasInteraction class >> example1 [

	^ (self canvasExample @ self) open
]

{ #category : #examples }
RSSelectionInCanvasInteraction class >> example2 [

	| interaction |
	interaction := self new.
	interaction shadowColor: Color red.
	^ (self canvasExample @ interaction) open
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> addInteractionToShape: aShape [

	(aShape hasInteraction: self class) ifTrue: [ ^ self ].
	aShape when: RSMouseLeftClick send: #processClick: to: self
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> addInteractionToShapes: aCanvas [

	aCanvas shapes do: [ :shape | self addInteractionToShape: shape ]
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> addInteractionsToCanvas: aCanvas [

	aCanvas
		when: RSShapeAddedEvent
		do: [ :evt | self addInteractionToShape: evt shape ]
		for: self;
		when: RSMouseLeftClick
		do: [ :evt | evt canvas setSelectedShapes: RSGroup new ]
		for: self
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> doHighlight: event [

	| shape |
	shape := event shape.
	shape @ shadowInteraction
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> doUnHighlight: event [

	shadowInteraction removeShadow: event
]

{ #category : #initialization }
RSSelectionInCanvasInteraction >> initialize [

	super initialize.
	elastic := RSElasticBoxInteraction new.
	shadowInteraction := RSShadowInteraction new.

	elastic
		when: RSSelectionStartEvent send: #selectionStart: to: self;
		when: RSSelectionChangedEvent send: #selectionChange: to: self;
		when: RSSelectionEndEvent send: #selectionEnd: to: self
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> onShape: aCanvas [

	aCanvas selectionInteraction: self.
	elastic targetShapes: aCanvas nodes.
	aCanvas @ elastic.
	self addInteractionsToCanvas: aCanvas.
	self addInteractionToShapes: aCanvas.
	aCanvas
		when: RSShapeAddedEvent
		do: [ :evt | self addInteractionToShape: evt shape ]
		for: self
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> processClick: evt [

	| shape canvas selectedShapes |
	evt shiftPressed ifFalse: [ ^ self ].
	shape := evt shape.
	canvas := evt canvas.
	selectedShapes := canvas selectedShapes asGroup.
	shape hasShadow
		ifTrue: [ selectedShapes remove: shape ]
		ifFalse: [ selectedShapes add: shape ].
	canvas setSelectedShapes: selectedShapes
]

{ #category : #rendering }
RSSelectionInCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Left click' description: 'Use drag and drop to select shapes'
]

{ #category : #'event processing' }
RSSelectionInCanvasInteraction >> selectionChange: evt [

	self setSelectedShapes: evt selectedShapes on: evt canvas
]

{ #category : #'event processing' }
RSSelectionInCanvasInteraction >> selectionEnd: evt [

	evt canvas selectedShapes: evt selectedShapes.
	evt canvas announce: evt
]

{ #category : #'event processing' }
RSSelectionInCanvasInteraction >> selectionStart: evt [

	shadowInteraction removeShadowsOn: evt canvas.
	evt canvas announce: evt
]

{ #category : #public }
RSSelectionInCanvasInteraction >> setSelectedShapes: aGroupOfShapes on: aRSCanvas [

	shadowInteraction removeShadowsOn: aRSCanvas. 
	aGroupOfShapes @ shadowInteraction.
	aRSCanvas selectedShapes: aGroupOfShapes.
	aRSCanvas announce: (RSSelectionChangedEvent new
			 selectedShapes: aGroupOfShapes;
			 yourself)
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor [

	^ shadowInteraction shadowColor
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor: aColor [ 
	shadowInteraction shadowColor: aColor
]
