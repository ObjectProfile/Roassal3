Class {
	#name : #RSSelectionInCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'shadowColor'
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

{ #category : #'accessing - defaults' }
RSSelectionInCanvasInteraction >> createBoxSelectionFor: shape [
	| border canvas |
	canvas := shape parent.
	shape removeSelectionBox.
			
	border := RSBox new
		cornerRadius: 10;
		noPaint;
		border: (RSBorder new 
			color: self shadowColor;
			width: 5;
			yourself);
		yourself.
	shape selectionBox: border.
	HUpdateSelectionBox new updateSelectionBox: shape.
	canvas addShape: border.
	border pushBack.
	
]

{ #category : #initialization }
RSSelectionInCanvasInteraction >> defaultShadowColor [

	^ Color black
]

{ #category : #initialization }
RSSelectionInCanvasInteraction >> initialize [

	super initialize.
	shadowColor := self defaultShadowColor.
]

{ #category : #hooks }
RSSelectionInCanvasInteraction >> onShape: aCanvas [

	| elastic selectionHigh |
	elastic := RSElasticBoxInteraction new.
	elastic leftRight.
	elastic targetShapes: aCanvas nodes.
	
	selectionHigh := RSHighlightable new
		                 when: RSHighlightEvent
		                 do: [ :evt | self createBoxSelectionFor: evt shape ];
		                 when: RSUnHighlightEvent
		                 do: [ :evt | evt shape removeSelectionBox ].
	elastic
		when: RSSelectionStartEvent
		do: [ :evt | selectionHigh unhighlightRecordedShapes: evt canvas ];
		when: RSSelectionChangedEvent do: [ :evt | 
			selectionHigh
				doHighlightShapes: evt selectedShapes
				onCanvas: evt canvas ];
		when: RSSelectionEndEvent
		do: [ :evt | evt canvas selectedShapes: evt selectedShapes ].
	aCanvas @ elastic
]

{ #category : #rendering }
RSSelectionInCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Left click' description: 'Use drag and drop to select shapes'
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor [

	^ shadowColor
]

{ #category : #accessing }
RSSelectionInCanvasInteraction >> shadowColor: aColor [ 
	shadowColor := aColor
]
