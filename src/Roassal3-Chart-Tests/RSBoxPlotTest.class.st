Class {
	#name : #RSBoxPlotTest,
	#superclass : #RSTest,
	#instVars : [
		'plot',
		'y'
	],
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #running }
RSBoxPlotTest >> setUp [

	super setUp.
	plot := RSBoxPlot new.
	y := {
		     { 1. 2 }.
		     { 3. 4 } }.
	plot y: y
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalIsOk [

	| median iqr |
	y := {
		     { 1. 2. 3. 4. 5 }.
		     { 1 } }.
	plot y: y.
	plot notch: true.
	plot build.
	median := (plot boxAndWhisker at: 1) at: 4.
	iqr := ((plot boxAndWhisker at: 1) at: 5) - ((plot boxAndWhisker at: 1) at: 3).

	self assert: ((plot boxAndWhisker at: 1) at: 8) equals: median + (1.57 * iqr/(5 sqrt)).
	self assert: ((plot boxAndWhisker at: 1) at: 9) equals: median - (1.57 * iqr/(5 sqrt))
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMaxIsGreaterThanQuartile3 [

	| confidenceIntervalMax quartile3 |
	y := {
		     { 1. 2. 3. 4. 5 }.
		     { 1 } }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMax := (plot boxAndWhisker at: 1) at: 8.
	quartile3 := (plot boxAndWhisker at: 1) at: 5.

	self assert: confidenceIntervalMax > quartile3
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMaxIsLesserThanQuartile3 [

	| confidenceIntervalMax quartile3 |
	y := {
		     { 1. 2. 3. 4. 5. 1. 2. 3. 4. 5. 1. 2. 3. 4. 5 }.
		     { 1 } }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMax := (plot boxAndWhisker at: 1) at: 8.
	quartile3 := (plot boxAndWhisker at: 1) at: 5.

	self assert: confidenceIntervalMax < quartile3
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMinIsGreaterThanQuartile1 [

	| confidenceIntervalMin quartile1 |
	y := {
		     { 1. 2. 3. 4. 5. 1. 2. 3. 4. 5. 1. 2. 3. 4. 5 }.
		     { 1 } }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMin := (plot boxAndWhisker at: 1) at: 9.
	quartile1 := (plot boxAndWhisker at: 1) at: 3.

	self assert: confidenceIntervalMin > quartile1
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMinIsLesserThanQuartile1 [

	| confidenceIntervalMin quartile1 |
	y := {
		     { 1. 2. 3. 4. 5 }.
		     { 1 } }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMin := (plot boxAndWhisker at: 1) at: 9.
	quartile1 := (plot boxAndWhisker at: 1) at: 3.

	self assert: confidenceIntervalMin < quartile1
]

{ #category : #tests }
RSBoxPlotTest >> testConfidencePercentageIsCorrectlyChanged [

	plot confidencePercentage: 99.
	plot build.

	self assert: plot confidencePercentage equals: 99
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultConfidencePercentageIs95 [

	plot y: {
			{ 1. 2 }.
			{ 3. 4 } }.
			
	self assert: plot confidencePercentage equals: 95
]

{ #category : #tests }
RSBoxPlotTest >> testNotchBasic [

	plot notch: true.
	
	plot build
]
