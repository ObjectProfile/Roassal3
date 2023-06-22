Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
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
RSViolinPlotTest >> testCreateDensityArea [
	| violinPlot data window |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := RSViolinPlot data: data.
	self assert: violinPlot densityArea isNil.
	window := violinPlot open.
	self assert: violinPlot densityArea class equals: RSPolygon.
	self assert: violinPlot densityArea points size > 0.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testDefaultComputeBoxWidth [
	| violinPlot data boxWidth |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	boxWidth := violinPlot boxWidth.
	self assert: boxWidth closeTo: 0.0072 precision: 4.
]

{ #category : #tests }
RSViolinPlotTest >> testDomainXValues [
	| violinPlot data minXCurve xs minXValue maxXValue maxXCurve|
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	xs := violinPlot densityAreaPoints collect: [:point | point x].
	minXCurve := xs min.
	maxXCurve := xs max.
	self assert: minXCurve closeTo: -0.0241 precision: 4.
	minXValue := violinPlot xValues min.
	maxXValue := violinPlot xValues max.
	self assert: minXValue closeTo: -0.03615 precision: 4.
]

{ #category : #tests }
RSViolinPlotTest >> testOutliersInsideChartDomain [
	| violinPlot data yValues outlierMax outlierMin |
	data := {-5. 12. 12. 13. 14. 15. 24. }.
	violinPlot := RSViolinPlot data: data.
	violinPlot buildChart.
	yValues := violinPlot yValues.
	outlierMax := violinPlot outliers max.
	outlierMin := violinPlot outliers min.
	self assert: ((yValues max) >= (outlierMax)).
	self assert: ((yValues min) <= (outlierMin)).
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
RSViolinPlotTest >> testSetErrorMargin [
	| violinPlot data densityAreaPointsBefore densityAreaPointsAfter |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := RSViolinPlot data: data.
	violinPlot buildChart.
	densityAreaPointsBefore := violinPlot densityAreaPoints size.
	violinPlot errorMargin: 0.00001.
	densityAreaPointsAfter := violinPlot densityAreaPoints size.
	self assert: densityAreaPointsBefore < densityAreaPointsAfter.
]

{ #category : #tests }
RSViolinPlotTest >> testViolinPlotHasStatisticalMeasures [
	| violinPlot data |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	self assert: violinPlot median closeTo: 30.
]

{ #category : #tests }
RSViolinPlotTest >> testWhiskersInsideChartDomain [
	| violinPlot data yValues upperWhisker |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := RSViolinPlot data: data.
	violinPlot buildChart.
	yValues := violinPlot yValues.
	upperWhisker := violinPlot upperWhiskerLimit.
	self assert: ((yValues last) >= (upperWhisker)).
]
