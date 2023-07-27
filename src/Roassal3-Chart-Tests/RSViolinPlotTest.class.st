Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSViolinPlotTest >> test4ViolinsAnd2Clusters [
	| violinPlotA violinPlotB data window chart |
	
	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testAxisLabelsAndTitle [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	violinPlot xlabel: 'X label'.
	violinPlot ylabel: 'Y label'.
	violinPlot title: 'Title'.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

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
RSViolinPlotTest >> testTwoViolinPlots [
	| violinPlot data window |
	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testTwoViolinPlotsClustered [
	| violinPlotA violinPlotB data window chart |
	
	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete.
]
