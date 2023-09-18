"
I have examples of RSSankey
"
Class {
	#name : #RSSankeyExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #examples }
RSSankeyExamples >> example01 [
	<script: 'self new example01 open'>
	| data b nodes links |
	data := self sankeyData.

	nodes := data at: 'nodes'.
	links := (data at: 'links') collect: [ :dict |
		RSSankeyLink new
			from: (nodes at: (dict at: 'source')+1);
			to: (nodes at: (dict at: 'target')+1);
			value: (dict at: 'value');
			yourself
		].

	b := RSSankey withAllLinks: links.
	b boxShape
		withBorder;
		borderColor: Color black;
		width: 15.

	b
		extent: 960@500;
		iterations: 32;
		nodePadding: 10.

	^ b
]

{ #category : #examples }
RSSankeyExamples >> example02Colors [
	<script: 'self new example02Colors open'>
	| b |
	b := self example01.
	b lineShape color: (Color blue alpha: 0.2).
	b labelShape color: Color black.
	b boxColor: NSScale category20c.
	^ b
]

{ #category : #examples }
RSSankeyExamples >> example03Colors [
	<script: 'self new example03Colors open'>
	| b colors |
	b := self example01.
	b lineShape color: (Color blue alpha: 0.2).
	b labelShape color: Color black.
	colors := NSScale category20c.
	b boxColor: [ :aString |
		| index key |
		index := aString indexOf: Character space.
		key := aString.
		index = 0
			ifFalse: [ key := key copyFrom: 1 to: index -1 ].
		colors scale: key ].
	^ b
]

{ #category : #examples }
RSSankeyExamples >> example04Popup [
	<script: 'self new example04Popup open'>
	| b |
	b := self example03Colors.
	b boxShape @ (RSPopup new
		model: #yourself;
		text: [:box | box model, String cr,
			(box propertyAt: #value) asString, ' TWh' ];
		yourself).
	b lineShape @ (RSPopup new
		text: [ :link | link asString, String cr, link value asString, ' TWh' ];
		yourself).
	^ b
]

{ #category : #examples }
RSSankeyExamples >> example05Animation [
	<script: 'self new example05Animation open'>
	| b blue blue2 |
	b := self example04Popup.
	b build.
	blue := Color blue alpha: 0.3.
	blue2 := Color blue alpha: 0.1.
	b canvas newAnimation
		repeat;
		duration: 3 seconds;
		easing: RSEasingInterpolator circleOut;
		onStepDo: [ :t |
			b lines do: [ :line |
				| paint |
				paint := LinearGradientPaint fromArray: {
					0 -> blue.
					(t-0.04) -> blue.
					t -> blue2.
					(t+0.04) -> blue.
					1 -> blue.
				}.
				paint
					start: line startPoint;
					stop: line endPoint.
				line color: paint. ].
			b canvas signalUpdate.
			 ].

	^ b canvas
]

{ #category : #examples }
RSSankeyExamples >> example06Gradient [
	<script: 'self new example06Gradient open'>
	| b |
	b := self example04Popup.
	b build.
	b lines do: [ :line |
		| paint |
		paint:= LinearGradientPaint fromArray: {
			0 -> line from color translucent.
			1 -> line to color translucent.
		}.
		paint
			start: line startPoint;
			stop: line endPoint.
		line color: paint.
		 ].
	^ b canvas
]

{ #category : #examples }
RSSankeyExamples >> sankeyData [
	<script: 'self new sankeyData inspect'>
	^ Dictionary new
		at: 'nodes' put: (OrderedCollection new
			add: 'Agricultural ''waste''';
			add: 'Bio-conversion';
			add: 'Liquid';
			add: 'Losses';
			add: 'Solid';
			add: 'Gas';
			add: 'Biofuel imports';
			add: 'Biomass imports';
			add: 'Coal imports';
			add: 'Coal';
			add: 'Coal reserves';
			add: 'District heating';
			add: 'Industry';
			add: 'Heating and cooling - commercial';
			add: 'Heating and cooling - homes';
			add: 'Electricity grid';
			add: 'Over generation / exports';
			add: 'H2 conversion';
			add: 'Road transport';
			add: 'Agriculture';
			add: 'Rail transport';
			add: 'Lighting & appliances - commercial';
			add: 'Lighting & appliances - homes';
			add: 'Gas imports';
			add: 'Ngas';
			add: 'Gas reserves';
			add: 'Thermal generation';
			add: 'Geothermal';
			add: 'H2';
			add: 'Hydro';
			add: 'International shipping';
			add: 'Domestic aviation';
			add: 'International aviation';
			add: 'National navigation';
			add: 'Marine algae';
			add: 'Nuclear';
			add: 'Oil imports';
			add: 'Oil';
			add: 'Oil reserves';
			add: 'Other waste';
			add: 'Pumped heat';
			add: 'Solar PV';
			add: 'Solar Thermal';
			add: 'Solar';
			add: 'Tidal';
			add: 'UK land based bioenergy';
			add: 'Wave';
			add: 'Wind';
			yourself);
		at: 'links' put: (OrderedCollection new
			add: (Dictionary new at: 'source' put: 0; at: 'target' put: 1; at: 'value' put: 124.729; yourself);
			add: (Dictionary new at: 'source' put: 1; at: 'target' put: 2; at: 'value' put: 0.597; yourself);
			add: (Dictionary new at: 'source' put: 1; at: 'target' put: 3; at: 'value' put: 26.862; yourself);
			add: (Dictionary new at: 'source' put: 1; at: 'target' put: 4; at: 'value' put: 280.322; yourself);
			add: (Dictionary new at: 'source' put: 1; at: 'target' put: 5; at: 'value' put: 81.144; yourself);
			add: (Dictionary new at: 'source' put: 6; at: 'target' put: 2; at: 'value' put: 35; yourself);
			add: (Dictionary new at: 'source' put: 7; at: 'target' put: 4; at: 'value' put: 35; yourself);
			add: (Dictionary new at: 'source' put: 8; at: 'target' put: 9; at: 'value' put: 11.606; yourself);
			add: (Dictionary new at: 'source' put: 10; at: 'target' put: 9; at: 'value' put: 63.965; yourself);
			add: (Dictionary new at: 'source' put: 9; at: 'target' put: 4; at: 'value' put: 75.571; yourself);
			add: (Dictionary new at: 'source' put: 11; at: 'target' put: 12; at: 'value' put: 10.639; yourself);
			add: (Dictionary new at: 'source' put: 11; at: 'target' put: 13; at: 'value' put: 22.505; yourself);
			add: (Dictionary new at: 'source' put: 11; at: 'target' put: 14; at: 'value' put: 46.184; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 16; at: 'value' put: 104.453; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 14; at: 'value' put: 113.726; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 17; at: 'value' put: 27.14; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 12; at: 'value' put: 342.165; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 18; at: 'value' put: 37.797; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 19; at: 'value' put: 4.412; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 13; at: 'value' put: 40.858; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 3; at: 'value' put: 56.691; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 20; at: 'value' put: 7.8629999999999995; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 21; at: 'value' put: 90.008; yourself);
			add: (Dictionary new at: 'source' put: 15; at: 'target' put: 22; at: 'value' put: 93.494; yourself);
			add: (Dictionary new at: 'source' put: 23; at: 'target' put: 24; at: 'value' put: 40.719; yourself);
			add: (Dictionary new at: 'source' put: 25; at: 'target' put: 24; at: 'value' put: 82.233; yourself);
			add: (Dictionary new at: 'source' put: 5; at: 'target' put: 13; at: 'value' put: 0.129; yourself);
			add: (Dictionary new at: 'source' put: 5; at: 'target' put: 3; at: 'value' put: 1.401; yourself);
			add: (Dictionary new at: 'source' put: 5; at: 'target' put: 26; at: 'value' put: 151.891; yourself);
			add: (Dictionary new at: 'source' put: 5; at: 'target' put: 19; at: 'value' put: 2.096; yourself);
			add: (Dictionary new at: 'source' put: 5; at: 'target' put: 12; at: 'value' put: 48.58; yourself);
			add: (Dictionary new at: 'source' put: 27; at: 'target' put: 15; at: 'value' put: 7.013; yourself);
			add: (Dictionary new at: 'source' put: 17; at: 'target' put: 28; at: 'value' put: 20.897; yourself);
			add: (Dictionary new at: 'source' put: 17; at: 'target' put: 3; at: 'value' put: 6.242; yourself);
			add: (Dictionary new at: 'source' put: 28; at: 'target' put: 18; at: 'value' put: 20.897; yourself);
			add: (Dictionary new at: 'source' put: 29; at: 'target' put: 15; at: 'value' put: 6.995; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 12; at: 'value' put: 121.066; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 30; at: 'value' put: 128.69; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 18; at: 'value' put: 135.835; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 31; at: 'value' put: 14.458; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 32; at: 'value' put: 206.267; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 19; at: 'value' put: 3.64; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 33; at: 'value' put: 33.218; yourself);
			add: (Dictionary new at: 'source' put: 2; at: 'target' put: 20; at: 'value' put: 4.413; yourself);
			add: (Dictionary new at: 'source' put: 34; at: 'target' put: 1; at: 'value' put: 4.375; yourself);
			add: (Dictionary new at: 'source' put: 24; at: 'target' put: 5; at: 'value' put: 122.952; yourself);
			add: (Dictionary new at: 'source' put: 35; at: 'target' put: 26; at: 'value' put: 839.978; yourself);
			add: (Dictionary new at: 'source' put: 36; at: 'target' put: 37; at: 'value' put: 504.287; yourself);
			add: (Dictionary new at: 'source' put: 38; at: 'target' put: 37; at: 'value' put: 107.703; yourself);
			add: (Dictionary new at: 'source' put: 37; at: 'target' put: 2; at: 'value' put: 611.99; yourself);
			add: (Dictionary new at: 'source' put: 39; at: 'target' put: 4; at: 'value' put: 56.587; yourself);
			add: (Dictionary new at: 'source' put: 39; at: 'target' put: 1; at: 'value' put: 77.81; yourself);
			add: (Dictionary new at: 'source' put: 40; at: 'target' put: 14; at: 'value' put: 193.026; yourself);
			add: (Dictionary new at: 'source' put: 40; at: 'target' put: 13; at: 'value' put: 70.672; yourself);
			add: (Dictionary new at: 'source' put: 41; at: 'target' put: 15; at: 'value' put: 59.901; yourself);
			add: (Dictionary new at: 'source' put: 42; at: 'target' put: 14; at: 'value' put: 19.263; yourself);
			add: (Dictionary new at: 'source' put: 43; at: 'target' put: 42; at: 'value' put: 19.263; yourself);
			add: (Dictionary new at: 'source' put: 43; at: 'target' put: 41; at: 'value' put: 59.901; yourself);
			add: (Dictionary new at: 'source' put: 4; at: 'target' put: 19; at: 'value' put: 0.882; yourself);
			add: (Dictionary new at: 'source' put: 4; at: 'target' put: 26; at: 'value' put: 400.12; yourself);
			add: (Dictionary new at: 'source' put: 4; at: 'target' put: 12; at: 'value' put: 46.477; yourself);
			add: (Dictionary new at: 'source' put: 26; at: 'target' put: 15; at: 'value' put: 525.531; yourself);
			add: (Dictionary new at: 'source' put: 26; at: 'target' put: 3; at: 'value' put: 787.129; yourself);
			add: (Dictionary new at: 'source' put: 26; at: 'target' put: 11; at: 'value' put: 79.329; yourself);
			add: (Dictionary new at: 'source' put: 44; at: 'target' put: 15; at: 'value' put: 9.452; yourself);
			add: (Dictionary new at: 'source' put: 45; at: 'target' put: 1; at: 'value' put: 182.01; yourself);
			add: (Dictionary new at: 'source' put: 46; at: 'target' put: 15; at: 'value' put: 19.013; yourself);
			add: (Dictionary new at: 'source' put: 47; at: 'target' put: 15; at: 'value' put: 289.366; yourself);
			yourself);
		yourself
]

{ #category : #examples }
RSSankeyExamples >> smallExample [

	<script: 'self new smallExample open'>
	| b |
	b := RSSankey withAllAssociations: {
			     (#Wages -> 2500 -> #Budget).
			     (#Interest -> 25 -> #Budget).
			     (#Budget -> 1000 -> #Taxes).
			     (#Budget -> 450 -> #Housing).
			     (#Budget -> 310 -> #Food).
			     (#Budget -> 205 -> #Transportation).
			     (#Budget -> 400 -> #'Health Care').
			     (#Budget -> 160 -> #'Other Necessities') }.
	b boxShape
		withBorder;
		borderColor: Color black;
		width: 15.

	b
		extent: 960 @ 500;
		iterations: 32;
		nodePadding: 10.

	^ b
]
