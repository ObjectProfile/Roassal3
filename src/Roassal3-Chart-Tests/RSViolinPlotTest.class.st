Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSViolinPlotTest >> testBasicViolinPlot [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testDefaultComputeBoxWidth [
	| violinPlot data boxWidth |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	boxWidth := violinPlot boxWidth.
	self assert: boxWidth closeTo: 0.0072.
]

{ #category : #tests }
RSViolinPlotTest >> testDomainXValues [
	| violinPlot data minXCurve xs minXValue maxXValue maxXCurve|
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	xs := violinPlot densityAreaPoints collect: [:point | point x].
	minXCurve := xs min.
	maxXCurve := xs max.
	self assert: minXCurve closeTo: -0.0241.
	minXValue := violinPlot xValues min.
	maxXValue := violinPlot xValues max.
	self assert: minXValue closeTo: -0.03615.
]

{ #category : #tests }
RSViolinPlotTest >> testOutliersPoints [
	| violinPlot data outlierPoints |
	data := { 12. 12. 13. 14. 15. 24. }.
	violinPlot := RSViolinPlot data: data.
	outlierPoints := violinPlot outlierPoints.
	self assert: outlierPoints size equals: 1.
	self assert: (outlierPoints at: 1) equals: 0@24.
]

{ #category : #tests }
RSViolinPlotTest >> testViolinPlotHasStatisticalMeasures [
	| violinPlot data |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	self assert: violinPlot median closeTo: 30.
]
