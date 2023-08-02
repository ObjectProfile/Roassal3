"
I have examples for open street map based on roassal2 previous examples
"
Class {
	#name : #RSOSMExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #examples }
RSOSMExamples >> example01Basic [
	<script: 'self new example01Basic inspect'>
	| canvas |
	canvas := RSCanvas new.
	canvas add: RSOSMShape new.
	canvas add: (RSBox new size: 100; draggable).
	canvas 
		@ RSDraggableCanvasInteraction;
		@ RSZoomableCanvasInteraction.

	canvas camera scale: 0.05.
	^ canvas
]

{ #category : #examples }
RSOSMExamples >> example02Builder [
	<script: 'self new example02Builder open'>
	| b |
	b := RSOSMBuilder new.
	^ b
]

{ #category : #examples }
RSOSMExamples >> example03CitySelection [

	<script: 'self new example03CitySelection open'>
	| b canvas high |
	b := RSOSMBuilder new.
	b build.
	canvas := b canvas.

	high := RSHighlightable blue.
	{
		'Buenos Aires'.
		(-34.6037 @ -58.3816).
		'Cairo'.
		(30.0444 @ 31.2357).
		'Cochabamba'.
		(-17.4139 @ -66.1653).
		'London'.
		(51.50722 @ -0.12750).
		'New York'.
		(40.7127 @ -74.0059).
		'Paris'.
		(48.8567 @ 2.3508).
		'Tokyo'.
		(35.6894 @ 139.6917) } pairsDo: [ :cityName :locationLatLong |
		| label |
		label := RSLabel text: cityName.
		label model: locationLatLong.
		label @ high.
		label isFixed: true.
		canvas addShape: label ].
	canvas fixedShapes
		when: RSMouseClick
		do: [ :evt | b latLong: evt shape model ]
		for: self.
	RSHorizontalLineLayout new
		gapSize: 10;
		on: canvas fixedShapes.
	^ canvas
]

{ #category : #examples }
RSOSMExamples >> example04Barcelona [
	<noTest>
	<script: 'self new example04Barcelona open'>
	| b canvas |
	b := RSOSMBuilder new.
	b build.
	canvas := b canvas.
	{
		'In'.
		1.5.
		'Out'.
		(1 / 1.5) } pairsDo: [ :text :newZoom |
		| label |
		label := RSLabel text: text.
		label model: newZoom.
		label isFixed: true.
		canvas addShape: label ].
	"this calls an api, with a limit then use it carefully :V "
	b moveToCity: 'Barcelona'.
	
	canvas fixedShapes
		@ RSHighlightable blue;
		when: RSMouseClick do: [ :evt |
			RSZoomableCanvasInteraction
				autoZoomMove: canvas
				newScale: evt camera scale * evt shape model.
			evt signalUpdate ]
		for: canvas.

	RSHorizontalLineLayout new
		gapSize: 10;
		on: canvas fixedShapes.

	^ canvas
]

{ #category : #examples }
RSOSMExamples >> example05ChartInLondon [
	<noTest>
	<script: 'self new example05ChartInLondon open'>
	| b canvas londonLocation chart |
	b := RSOSMBuilder new.
	b build.
	canvas := b canvas.
	londonLocation := (51.50722 @ -0.12750).
	
	b latLong: londonLocation.
	chart := RSBarChartExample new example03TilePaint asShape.
	chart scaleBy: 0.5.
	chart color: (Color white alpha: 0.8).
	chart position: (b latLogToRoassalCoordinates: londonLocation).
	b canvas add: chart.
	^ b canvas.
]
