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
