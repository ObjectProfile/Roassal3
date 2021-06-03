"
Examples related to timeline
"
Class {
	#name : #RSTimelineExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
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
	chart := RSChart new.
	data doWithIndex: [ :line :index |
		plot := RSTimeLinePlot new.
		plot entries: line at: index.
		chart addPlot: plot.
	].
	chart addDecoration: (RSVerticalTick new fromNames: names).
	chart addDecoration: (RSHorizontalTick new 
		doNotUseNiceLabel;
		numberOfTicks: 5;
		useDiagonalLabel;
		labelConversion: [ :v | Date year: 2021 day: v ];
		yourself).
	chart build.
	chart plots doWithIndex: [ :p :index |
		p bars @ (RSPopup text: [ :assoc | 
			(names at: index), String cr, assoc asString ]) ].
	^ chart canvas
]

{ #category : #examples }
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
	chart := RSChart new.
	data doWithIndex: [ :line :index |
		plot := RSTimeLinePlot new.
		plot entries: line at: index.
		chart addPlot: plot.
	].
	chart addDecoration: (RSVerticalTick new fromNames: names).
	chart addDecoration: (RSHorizontalTick new 
		doNotUseNiceLabel;
		numberOfTicks: 5;
		useDiagonalLabel;
		labelConversion: [ :v | Date year: 2021 day: v ];
		yourself).
	chart build.
	chart plots doWithIndex: [ :p :index |
		p bars
			@ (RSPopup text: [ :assoc | 
				(names at: index), String cr, assoc asString ]);
			@ (RSLabeledInteraction new 
				text: [ names at: index ];
				lowColor: Color black;
				highlightable;
				locationDo: [ :loc | loc middle ]) ].
	^ chart canvas
]
