"
Examples related to timeline
"
Class {
	#name : 'RSTimelineExample',
	#superclass : 'RSAbstractExamples',
	#instVars : [
		'lastDay'
	],
	#category : 'Roassal-Chart-Examples',
	#package : 'Roassal-Chart-Examples'
}

{ #category : 'examples' }
RSTimelineExample >> createRandomData [
	| perlin r |
	perlin := NSPerlinNoise3 new octaves: 3.
	r := Random new.
	r seed: 777.
	^ (1 to: 25) collect: [:each | | time n |
		time := 0.
		n := ((perlin noise: each log and: 0) * 100) asInteger.
		n odd ifTrue: [ n := n + 1 ]. "n must be even"
		(1 to: n) collect: [ :x | | factor |
			factor := r next * 30.
			time := time + ((perlin noise: x*0.001 and: each log) * factor) asInteger.
			].
		]
]

{ #category : 'examples' }
RSTimelineExample >> example01Gantt [
	<script: 'self new example01Gantt open'>
	| chart data names plot |

	data := #(
		#(0 5 6 8)
		#(0 5 8 10)
		#(0 10)
		#(5 10)
		#(5 8)).
	names := #(c1 c2 c3 c4 c5).
	chart := RSCompositeChart new.
	data doWithIndex: [ :line :index |
		plot := RSTimeLinePlot new.
		plot entries: line at: index.
		chart add: plot.
	].
	chart verticalTick fromNames: names.
	chart horizontalTick doNotUseNiceLabel;
		numberOfTicks: 5;
		useDiagonalLabel;
		labelConversion: [ :v | Date year: 2021 day: v ].
	chart build.
	chart plots doWithIndex: [ :p :index |
		p bars @ (RSPopup text: [ :assoc |
			(names at: index), String cr, assoc asString ]) ].
	^ chart canvas
]

{ #category : 'examples' }
RSTimelineExample >> example02Labeled [
	<script: 'self new example02Labeled open'>
	| chart data names plot |

	data := #(
		#(0 5 6 8)
		#(0 5 8 10)
		#(0 10)
		#(5 10)
		#(5 8)).
	names := #(c1 c2 c3 c4 c5).
	chart := RSCompositeChart new.
	data doWithIndex: [ :line :index |
		plot := RSTimeLinePlot new.
		plot entries: line at: index.
		chart add: plot.
	].
	chart verticalTick fromNames: names.
	chart horizontalTick doNotUseNiceLabel;
		numberOfTicks: 5;
		useDiagonalLabel;
		labelConversion: [ :v | Date year: 2021 day: v ].
	chart build.
	chart plots doWithIndex: [ :p :index |
		p bars
			@ (RSPopup text: [ :assoc |
				(names at: index), String cr, assoc asString ]);
			@ (RSLabeled new
				text: [ names at: index ];
				lowColor: Color black;
				highlightable;
				locationDo: [ :loc | loc middle ]) ].
	^ chart canvas
]

{ #category : 'examples' }
RSTimelineExample >> example03ZoomInAxis [
	<script: 'self new example03ZoomInAxis open'>
	| data chart names |
	chart := RSCompositeChart new.
	chart extent: 500@200.
	chart padding: 10@0.
	data := self createRandomData.

	names := (1 to: data  size) collect: [ :each | 'Series ', each asString ].
	chart addAll: (data collectWithIndex: [ :line :index |
		 RSTimeLinePlot new
			entries: line at: index;
			yourself ]).
	chart verticalTick fromNames: names.
	chart horizontalTick doNotUseNiceLabel;
		numberOfTicks: 10;
		useDiagonalLabel;
		labelConversion: [ :day | self printDate: day ].
	chart addDecoration: RSZoomTickDecoration new.
	^ chart
]

{ #category : 'examples' }
RSTimelineExample >> printDate: day [
	| label |
	"use a method, remeber this is an example"
	label := lastDay ifNil: [
		Date year: Year current year day: day
	] ifNotNil: [ | difference |
		difference := day - lastDay.
		difference < 0 ifTrue: [
			Date year: Year current year day: day
		] ifFalse: [
			difference < 1 "one day" ifTrue: [
				label := DateAndTime year: Year current year day: day.
				label asDate asString, ', ', label asTime print24 ]
			ifFalse: [ Date year: Year current year day: day ]
		]
	].
	lastDay := day.
	^ label
]
