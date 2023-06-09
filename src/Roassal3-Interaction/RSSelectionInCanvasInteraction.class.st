Class {
	#name : #RSSelectionInCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'shadowColor',
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

{ #category : #initialization }
RSSelectionInCanvasInteraction >> defaultShadowColor [

	^ Color black
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
	shadowColor := self defaultShadowColor.
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
	aCanvas @ elastic
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

	^ shadowColor
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor: aColor [ 
	shadowColor := aColor
]
