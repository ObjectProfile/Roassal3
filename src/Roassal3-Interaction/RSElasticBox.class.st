"
Elastic box interaction creates an selection box for a group o elements

this interaction works with an announcer. with this events `RSSelectionChangedEvent`, `RSSelectionEndEvent` and `RSSelectionEndEvent`.

"
Class {
	#name : #RSElasticBox,
	#superclass : #RSAbstractCanvasInteraction,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'events',
		'draggingCanvas',
		'announcer',
		'baseBox',
		'selectedShapes',
		'startPosition',
		'shouldUseNegativeBox',
		'targetShapes'
	],
	#category : #'Roassal3-Interaction-ElasticBox'
}
