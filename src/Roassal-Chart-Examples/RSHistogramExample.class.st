"
Examples of RSHistogramPlot
"
Class {
	#name : 'RSHistogramExample',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Chart-Examples',
	#package : 'Roassal-Chart-Examples'
}

{ #category : 'examples' }
RSHistogramExample >> example01RandomValues [
	<script: 'self new example01RandomValues open'>
	| c p values |
	values := self randomValues.
	c := RSCompositeChart new.
	p := RSLinePlot new x:(1 to: values size) y: values.
	c add: p.
	c horizontalTick doNotUseNiceLabel.
	^ c
]

{ #category : 'examples' }
RSHistogramExample >> example02Histogram [
	<script: 'self new example02Histogram open'>
	| values c plot |
	values := self randomValues.
	c := RSCompositeChart new.
	plot := RSHistogramPlot new x: values.
	c add: plot.
	c title: 'My Chart'.
	^ c
]

{ #category : 'examples' }
RSHistogramExample >> example03Bins [
	<script: 'self new example03Bins open'>
	| values  canvas shapes |
	values := self randomValues.
	canvas := RSCanvas new.
	shapes := #(3 5 10 20) collect: [ :numberOfBins| | g c plot |
		g := RSGroup new.
		c := RSCompositeChart new.
		c container: g.
		plot := RSHistogramPlot new x: values; numberOfBins: numberOfBins.
		c add: plot.
		c title: numberOfBins.
		c build.
		g asShapeFor: numberOfBins.
		 ].
	canvas addAll: shapes.
	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : 'examples' }
RSHistogramExample >> example04BinningStrat [
	<script: 'self new example04BinningStrat open'>
	| values  canvas shapes |
	"Do we need a binning strat?"
	values := self randomValues: 0 scale: 20 size: 1000.
	canvas := RSCanvas new.
	shapes := {
		RSDefaultBinning new.
		RSRiceBinning new.
		RSSturgesBinning new.
	 } collect: [ :strat | | g c plot |
		g := RSGroup new.
		c := RSCompositeChart new.
		c container: g.
		plot := RSHistogramPlot new x: values; binningStrategy: strat.
		c add: plot.
		c title: strat class name.
		c build.
		g asShapeFor: strat.
		 ].
	canvas addAll: shapes.
	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : 'examples' }
RSHistogramExample >> example05Interactions [
	<script: 'self new example05Interactions open'>
	| c p |
	c := self example02Histogram.
	c build.
	p := c plots last.
	p bars @ RSPopup new.
	^ c canvas
]

{ #category : 'examples' }
RSHistogramExample >> example06Animations [
	<script: 'self new example06Animations open'>
	| c p |
	c := self example02Histogram.
	c build.
	p := c plots last.
	p bars do: [ :shape |
		| zeroPoint originalPoint rect|
		rect := shape encompassingRectangle.
		originalPoint := rect origin.
		zeroPoint := rect origin x @ rect corner y.
		shape newAnimation
			from: zeroPoint;
			to: originalPoint;
			easing: RSEasingInterpolator elasticOut;
			onStepDo: [ :newPoint |
				shape
					fromRectangle: (newPoint corner: rect corner);
					signalUpdate.
			].
		 ].
	p bars
		@ (RSHighlightable new highlightBorder: (RSBorder new color: Color black));
		@ (RSPopup text: [:assoc |
			"TODO create an object to define the model for each bin"
			'From: ', (assoc key key round: 3) asString, String cr,
			'To: ', (assoc key value round: 3) asString, String cr,
			'Size: ', assoc value asString ]).
	^ c canvas
]

{ #category : 'examples' }
RSHistogramExample >> example07Shortcut [
	<script: 'self new example07Shortcut open'>
	^ self randomValues rsHistogram
]

{ #category : 'examples' }
RSHistogramExample >> example08Strategies [
	<script: 'self new example08Strategies open'>
	| x y canvas shapes |
	"Do we need a binning strat?"
	x := 1 to: 100.
	canvas := RSCanvas new.
	shapes := {
		RSDefaultBinning new.
		RSRiceBinning new.
		RSSturgesBinning new.
	 } collect: [ :strat | | g c plot |
		g := RSGroup new.
		c := RSCompositeChart new.
		c container: g.
		y := x collect: [ :v | strat computeNumberOfBinsFor: (Array new: v) ].
		plot := RSLinePlot new x: x y: y.
		c add: plot.
		c verticalTick doNotUseNiceLabel.
		c title: strat class name.
		c build.
		g asShapeFor: strat.
		 ].
	canvas addAll: shapes.
	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : 'examples' }
RSHistogramExample >> example09BinsCollection [
	<script: 'self new example09BinsCollection open'>
	| values c plot |
	values := self randomValues.
	c := RSCompositeChart new.
	plot := RSHistogramPlot new x: values.
	plot bins: #(100 150 155 180 200).
	c add: plot.
	^ c
]

{ #category : 'examples' }
RSHistogramExample >> example10Objects [
	<script: 'self new example10Objects open'>
	| c plot classes tick |
	classes := Collection withAllSubclasses.

	c := RSCompositeChart new.
	c padding: 10@10.
	c extent: 300@200.
	plot := RSHistogramPlot of: classes on: #linesOfCode.
	plot bins: (0 to: 1000 by: 20) , {1000. 2000. 3000 }.

	tick := c verticalTick.
	tick configuration tickSize: -300.
	tick color: Color lightGray.
	tick shape width: 0.5.
	c add: plot.
	c build.

	plot bars @ (RSPopup text: [:classesToShow |
		String streamContents: [ :stream |
			classesToShow do: [ :cls |
				cls printOn: stream.
				stream << ' LOC: '.
				(plot map at: cls) printOn: stream ]
			separatedBy: [ stream cr ].
			]
		]).
	^ c canvas
]

{ #category : 'computing' }
RSHistogramExample >> normal: x mean: mean stdDev: std [
	^ (-0.5 * Float twoPi log - std log -
		 ( ((x - mean) raisedTo: 2) / (2 * std * std))) exp
]

{ #category : 'computing' }
RSHistogramExample >> randomValues [
	<script: 'self new randomValues inspect'>
	^ self randomValues: 170 scale: 10 size: 250
]

{ #category : 'computing' }
RSHistogramExample >> randomValues: loc scale: scale size: size [
	| low upp mean stdDev r |
	"TODO generate a new method to creatte random values with normal distribution"
	low := 0.
	upp := 100.
	mean := (low + upp) / 2.
	stdDev := (upp - low)/4.
	r := Random new.

	^ ((1 to: size ) collectWithIndex: [ :i :index |
		| val sign rval |
		rval := r rsNext:0-mean and: upp + mean.
		val := self normal: rval mean: mean stdDev: stdDev.
		sign := index < (size / 2) ifTrue: [ -1 ] ifFalse: [ 1 ].

		loc +(size * val * sign)
		 ]) shuffled
]
