"
I have examples for open street map based on roassal2 previous examples
"
Class {
	#name : #RSOSMExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #examples }
RSOSMExamples >> customPopup [
	| popup |
	popup := RSPopup new.
	popup shapeBuilder labelBuilder: [ :model | | fields |
		fields := (model keys sorted: [ :x :y | x < y ]) flatCollect: [ :key |
			| field value |
			field := RSLabel text: key,': '.
			field bold.
			value := RSLabel text: (model at: key).
			{ field. value }
			 ].
		RSCellLayout new 
			lineItemsCount: 2;
			on: fields.
		fields asShape
			position: 0@0 ].
	^ popup
]

{ #category : #examples }
RSOSMExamples >> downloadSeismData [
	<script: 'self new downloadSeismData inspect'>
	| csv lines headers|
	csv := (ZnEasy get: 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_month.csv') contents.
	lines := csv lines.
	headers := lines first splitOn: ','.
	^ lines allButFirst collect: [ :line | | dict |
		dict := Dictionary new.
		(line findTokens: ',' escapedBy: '"') with: headers do: [ :value :header |
			dict at: header put: value ].
		dict
		 ].
	
]

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
	canvas addShape: chart.
	^ canvas.
]

{ #category : #examples }
RSOSMExamples >> example06SeismOnEarth [
	<noTest>
	<script: 'self new example06SeismOnEarth open
		extent: 750@550
	'>
	| b canvas data masterShape |
	b := RSOSMBuilder new.
	b build.
	canvas := b canvas.
	data := self downloadSeismData.
	masterShape := RSEllipse new.
	
	masterShape @ self customPopup.
	masterShape @ RSHighlightable blue.
	canvas addAll: (data collect: [ :row | | mag lat lon |
		mag := (row at: 'mag') asNumber.
		lat := (row at: 'latitude') asNumber.
		lon := (row at: 'longitude') asNumber.
		masterShape copyWithAnnouncer
			model: row;
			size: (2 raisedTo: mag)*10;
			color: Color red translucent;
			position: (b latLogToRoassalCoordinates: lat @ lon);
			yourself
		 ]).
	canvas camera scale: 0.02.
	^ canvas.
]

{ #category : #examples }
RSOSMExamples >> example07SeismOnEarthAnimated [
	<noTest>
	<script: 'self new example07SeismOnEarthAnimated open
		extent: 750@550
	'>
	| canvas shapes animations magScale dateLabel locationLabel |
	canvas := self example06SeismOnEarth.
	shapes := canvas nodes select: [ :each | each class = RSEllipse ].
	shapes do: #remove.
	
	"setup"
	shapes do: [ :each |
		each 
			propertyAt: #time 
			put: (DateAndTime fromString: (each model at: 'time'));
			propertyAt: #mag
			put: (each model at: #mag) asNumber ].
	magScale := NSScale linear
		domain: { 1. 5. 6. 7. 8. 1000 };
		range: { 250. 500. 1000. 2000. 3000. 5000}.
	"sorting"
	shapes := shapes sorted: [ :a :b | | timeA timeB |
		timeA := a propertyAt: #time.
		timeB := a propertyAt: #time.
		timeA asDuration < timeB asDuration.
		].
	dateLabel := RSLabel new position: 0@ -10; yourself.
	locationLabel := RSLabel new position: 0@10; yourself.
	canvas add: ({dateLabel. locationLabel} asShape
		position: 0@ -10000;
		scaleBy: 50;
		yourself).
	
	animations := shapes collect: [ :shape |
		self newAnimationFor: {shape. dateLabel. locationLabel. canvas. magScale} ].
	canvas animationFrom: animations.
	^ canvas.
]

{ #category : #examples }
RSOSMExamples >> newAnimationFor: data [
	| shape dateLabel locationLabel canvas magScale duration lineStart |
	shape := data first.
	dateLabel := data second.
	locationLabel := data third.
	canvas := data fourth.
	magScale := data fifth.
	duration := (magScale scale: (shape propertyAt: #mag)) milliSeconds.
	lineStart := 0@ -9000.
	^ RSParallelAnimation new
	 	add: (RSTransitionAnimation new
			duration: duration;
			easing: RSEasingInterpolator elasticOut;
			scale: (NSScale linear
				domain: {0. 0.25. 0.5. 0.75. 1};
				range: {0. shape width *2. 0. shape width * 1.5. shape width } );
			when: RSAnimationStartEvent do: [ | time |
				time := shape propertyAt: #time.
				dateLabel text: time asDate asString, ' ', time asTime print24.
				locationLabel text: (shape model at: #place).
				duration traceCr.
				canvas add: shape ] for: self;
			onStepDo: [ :t | 
				shape size: t.
				];
			when: RSAnimationEndEvent do: [ shape color: Color gray translucent ] for: self);
		add: (self newLineAnimationFor: data);
		yourself
		
]

{ #category : #examples }
RSOSMExamples >> newLineAnimationFor: data [
	| shape lineStart canvas magScale duration |
	shape := data first.
	canvas := data fourth.
	magScale := data fifth.
	duration := (magScale scale: (shape propertyAt: #mag)) milliSeconds.
	lineStart := 0@ -9000.
	^ RSTransitionAnimation new
		easing: RSEasingInterpolator sinOut;
		duration: duration;
		from: lineStart;
		to: shape position;
		
		onStepDo: [ :t |
			canvas lines ifEmpty: [ 
				canvas add: (RSLine new
					startPoint: lineStart;
					endPoint: lineStart;
					width: 50;
					markerEnd: (RSShapeFactory arrow
						size: 300;
						yourself);
					color: Color black;
					yourself) ].
			canvas lines first endPoint: t. canvas signalUpdate ];
		when: RSAnimationStartEvent do: [ canvas lines copy do: #remove. ] for: self;
		yourself
]
