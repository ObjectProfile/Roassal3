Class {
	#name : #RSSelectionInCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'elastic',
		'shadowInteraction',
		'withoutNilModels'
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

{ #category : #'instance creation' }
RSSelectionInCanvasInteraction class >> withoutNilModels [

	^ self new
		  withoutNilModels: true;
		  yourself
]

{ #category : #interactions }
RSSelectionInCanvasInteraction >> addInteractionToShape: aShape [

	((aShape hasInteraction: self class) or: [ aShape isLine ]) ifTrue: [ 
		^ self ].
	aShape when: RSMouseLeftClick send: #processClick: to: self
]

{ #category : #interactions }
RSSelectionInCanvasInteraction >> addInteractionToShapes: aCanvas [

	aCanvas nodes do: [ :shape | self addInteractionToShape: shape ]
]

{ #category : #interactions }
RSSelectionInCanvasInteraction >> addInteractionsToCanvas: aCanvas [

	aCanvas
		when: RSShapeAddedEvent
		do: [ :evt | self addInteractionToShape: evt shape ]
		for: self;
		when: RSMouseLeftClick
		do: [ :evt | evt canvas setSelectedShapes: RSGroup new ]
		for: self;
		when: RSKeyDown send: #processKeyDown: to: self
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> elasticBoxInteraction [
	^ elastic
]

{ #category : #initialization }
RSSelectionInCanvasInteraction >> initialize [

	super initialize.
	elastic := RSElasticBoxInteraction new.
	shadowInteraction := RSShadowInteraction new.
	self withoutNilModels: false.

	elastic
		when: RSSelectionStartEvent send: #selectionStart: to: self;
		when: RSSelectionChangedEvent send: #selectionChange: to: self;
		when: RSSelectionEndEvent send: #selectionEnd: to: self
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> keyToSelect [

	^ 'A'
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

{ #category : #'event processing' }
RSSelectionInCanvasInteraction >> processClick: evt [

	| shape canvas selectedShapes |
	evt shiftPressed ifFalse: [ ^ self ].
	shape := evt shape.
	canvas := evt canvas.
	selectedShapes := RSGroup withAll: canvas selectedShapes.
	shape hasShadow
		ifTrue: [ selectedShapes remove: shape ]
		ifFalse: [ selectedShapes add: shape ].
	canvas setSelectedShapes: selectedShapes.
	canvas signalUpdate
]

{ #category : #'event processing' }
RSSelectionInCanvasInteraction >> processKeyDown: evt [

	| canvas |
	((evt commandKeyPressed or: [ evt controlKeyPressed ]) and: [ 
		 evt keyName = self keyToSelect ]) ifFalse: [ ^ self ].
	canvas := evt canvas.
	canvas setSelectedShapes: canvas nodes.
	canvas signalUpdate
]

{ #category : #rendering }
RSSelectionInCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Shift + Left click' description: 'Drag the mouse to select shapes'
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
	| canvas |
	canvas := evt canvas.
	shadowInteraction removeShadowsOn: canvas.
	canvas selectedShapes: #().
	canvas announce: evt
]

{ #category : #public }
RSSelectionInCanvasInteraction >> setSelectedShapes: aGroupOfShapes on: aRSCanvas [

	| filteredShapes selectedShapes shapesToRemoveShadow shapesToPutShadow |
	filteredShapes := self withoutNilModels
		                  ifTrue: [ 
		                  aGroupOfShapes select: [ :shape | 
			                  shape model isNotNil ] ]
		                  ifFalse: [ aGroupOfShapes ].
		
	selectedShapes := aRSCanvas selectedShapes.
	
	shapesToRemoveShadow := selectedShapes difference: filteredShapes.
	self unselectShapes: shapesToRemoveShadow in: aRSCanvas.

	shapesToPutShadow := filteredShapes difference: selectedShapes.

	shapesToPutShadow @ shadowInteraction.
	aRSCanvas selectedShapes: filteredShapes copy.
	aRSCanvas announce: (RSSelectionChangedEvent new
			 selectedShapes: filteredShapes;
			 yourself).
	aRSCanvas signalUpdate
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor [

	^ shadowInteraction shadowColor
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor: aColor [ 
	shadowInteraction shadowColor: aColor
]

{ #category : #public }
RSSelectionInCanvasInteraction >> unselectShapes: aGroupOfShapes in: aCanvas [

	| key |
	aGroupOfShapes do: [ :s | s removeShadow ].
	key := shadowInteraction key.
	aCanvas
		propertyAt: key
		ifPresent: [ :list |
		aGroupOfShapes do: [ :s | list remove: s ifAbsent: [  ] ] ]
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> withoutNilModels [

	^ withoutNilModels
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> withoutNilModels: aBoolean [

	withoutNilModels := aBoolean 
]
